import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../provider/cart_provider.dart';
import '../sausage_roll_detail_screen.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/quantity_control_row.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;

  const ProductGridItem({required this.product});

  bool isProductAvailable() {
    final DateTime currentDate = DateTime.now();
    return currentDate.isAfter(product.availableFrom) &&
        currentDate.isBefore(product.availableUntil);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext ctx) => SausageRollDetailPage(
              sausageRoll: product,
            ),
          ),
        );
      },
      // Set the color based on product availability
      child: Card(
        color: isProductAvailable()
            ? Colors.white
            : const Color.fromARGB(255, 150, 150, 150),
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.thumbnailUri,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Image failed to load');
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProductInfoRow(
                      product.articleName, product.eatOutPrice, context),
                  const SizedBox(height: 8),
                  Text(
                    product.internalDescription,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      int itemCount =
                          cartProvider.getProductQuantity(product.articleCode);
                      return isProductAvailable()
                          ? itemCount > 0
                              ? QuantityControlRow(
                                  itemCount: itemCount,
                                  articleCode: product.articleCode,
                                )
                              : AddToCartButton(product: product)
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfoRow(String name, double price, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          '\£${price.toStringAsFixed(2)}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
