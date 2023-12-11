import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_item.dart';
import '../provider/cart_provider.dart';
import '../widgets/quantity_control_row.dart';

class CartListItem extends StatelessWidget {
  final CartItem cartItem;
  final int index;

  const CartListItem({
    Key? key,
    required this.cartItem,
    required this.index,
  }) : super(key: key);

  bool isProductAvailable() {
    final DateTime currentDate = DateTime.now();
    return currentDate.isAfter(cartItem.product.availableFrom) &&
        currentDate.isBefore(cartItem.product.availableUntil);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:
            isProductAvailable() ? Colors.white : Colors.grey.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              cartItem.product.thumbnailUri,
              fit: BoxFit.cover,
              width: 67,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image failed to load');
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.articleName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 1),
                  // Check if the product is available, and if so, display the price and quantity controls
                  if (isProductAvailable())
                    Row(
                      children: [
                        Text(
                          '\£${cartItem.product.eatInPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Expanded(child: Container()),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            QuantityControlRow(
                              itemCount: cartItem.quantity,
                              articleCode: cartItem.product.articleCode,
                            )
                          ],
                        ),
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
