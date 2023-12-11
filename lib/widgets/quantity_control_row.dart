import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class QuantityControlRow extends StatelessWidget {
  final int itemCount;
  final String articleCode;

  const QuantityControlRow({
    Key? key,
    required this.itemCount,
    required this.articleCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false)
                .decreaseCartItemQuantity(articleCode, itemCount, '');
          },
        ),
        Text(itemCount.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false)
                .increaseCartItemQuantity(articleCode, itemCount, '');
          },
        ),
      ],
    );
  }
}
