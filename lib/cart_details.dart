import 'package:flutter/material.dart';
import 'package:greggs_app/widgets/common_appbar.dart';
import 'package:provider/provider.dart';
import '../listitem/cart_list_item.dart';
import '../model/cart_item.dart';
import '../provider/cart_provider.dart';
class CartDetails extends StatelessWidget {
  const CartDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(pageName: 'Shopping Cart'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CartItemList(),
            ),
            CartSummarySection(),
          ],
        ),
      ),
    );
  }
}

class CartItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final List<CartItem> cartItems = cartProvider.cartItems;

        if (cartItems.isEmpty) {
          return Center(
            child: Text(
              'Your cart is empty.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartItems[index];
            return CartListItem(cartItem: cartItem, index: index);
          },
        );
      },
    );
  }
}

class CartSummarySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Container()),
                  // Display an ElevatedButton for clearing the cart if it contains items.
                  if (cartProvider.cartCount > 0)
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .clearCart();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Clear Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Total Price:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(child: Container()),
                  Text(
                    '\£${cartProvider.totalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CartCheckoutButton(),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class CartCheckoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Handling checkout
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          elevation: 10,
        ),
        child: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
