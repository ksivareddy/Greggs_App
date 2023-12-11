import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../provider/cart_provider.dart';


class AddToCartButton extends StatelessWidget {
  final Product product;

  const AddToCartButton({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {
        Provider.of<CartProvider>(context, listen: false).addToCart(product, 1, "");
      },
    );
  }
}
