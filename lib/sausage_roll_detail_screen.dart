import 'package:flutter/material.dart';
import 'package:greggs_app/model/product.dart';
import 'package:provider/provider.dart';

import 'widgets/common_appbar.dart';
import 'provider/cart_provider.dart';
import 'widgets/quantity_control_row.dart';

class SausageRollDetailPage extends StatelessWidget {
  final Product sausageRoll;

  SausageRollDetailPage({required this.sausageRoll});

  String getFormattedAvailableUntil() {
    return '${sausageRoll.availableUntil.year}-${sausageRoll.availableUntil.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
// Determine if the sausage roll is currently available based on its day parts and time range.
    bool isAvailableNow = false;
    for (final dayPart in sausageRoll.dayParts) {
      if (dayPart == 'Breakfast' &&
          currentTime.isAfter(sausageRoll.availableFrom) &&
          currentTime.isBefore(sausageRoll.availableUntil)) {
        isAvailableNow = true;
        break;
      } else if (dayPart == 'Lunch' &&
          currentTime.isAfter(sausageRoll.availableFrom) &&
          currentTime.isBefore(sausageRoll.availableUntil)) {
        isAvailableNow = true;
        break;
      } else if (dayPart == 'Evening' &&
          currentTime.isAfter(sausageRoll.availableFrom) &&
          currentTime.isBefore(sausageRoll.availableUntil)) {
        isAvailableNow = true;
        break;
      }
    }

    return Scaffold(
      appBar: const CommonAppBar(pageName: 'Greggs'),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
              child: Image.network(
                sausageRoll.imageUri,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Image failed to load');
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    sausageRoll.articleName,
                    style: const TextStyle(
                        color: Color.fromARGB(162, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isAvailableNow ? 'Available Now' : 'Not Available Now',
                        style: TextStyle(
                          fontSize: 16,
                          color: isAvailableNow ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Display an ElevatedButton for adding the sausage roll to the cart if it is currently available.
                      // The button triggers the 'addToCart' functionality from the CartProvider.
                      if (isAvailableNow)
                        ElevatedButton(
                          onPressed: () {
                            // Add to Cart functionality
                            Provider.of<CartProvider>(context, listen: false)
                                .addToCart(sausageRoll, 1, "");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item added to cart'),
                              ),
                            );
                          },
                          child: Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                              int itemCount = cartProvider
                                  .getProductQuantity(sausageRoll.articleCode);
                              return isAvailableNow
                                  ? itemCount > 0
                                      ? QuantityControlRow(
                                          itemCount: itemCount,
                                          articleCode: sausageRoll.articleCode)
                                      : const Text(
                                          'Add to Cart') // Display 'Add to Cart' when there are no items in the cart
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Container(
                      child: Text(
                        sausageRoll.customerDescription,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
