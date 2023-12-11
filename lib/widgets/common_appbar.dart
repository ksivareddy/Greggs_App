import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart_details.dart';
import '../provider/cart_provider.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;

  const CommonAppBar({required this.pageName});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      automaticallyImplyLeading: false,
      foregroundColor: Color.fromARGB(255, 0, 0, 0),
      backgroundColor: Color.fromARGB(255, 181, 216, 245),
      actions: [
        SizedBox(width: 20),
        LogoWidget(),
        const Spacer(),
        PageTitleWidget(pageName: pageName),
        const Spacer(),
        CartIconWidget(),
      ],
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Greggs.png',
      fit: BoxFit.cover,
      width: 30,
      height: 30,
    );
  }
}

class PageTitleWidget extends StatelessWidget {
  final String pageName;

  const PageTitleWidget({required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        pageName,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CartIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  // Get the current route name or set it to 'Unknown' if not available
  String currentRouteName = ModalRoute.of(context)?.settings.name ?? 'Unknown';

print('Current Route Name: $currentRouteName');

// Consumer to listen for changes in the cart and rebuild the widget accordingly
return Consumer<CartProvider>(
  builder: (context, cartProvider, child) {
    int cartItemCount = cartProvider.cartCount;
    
    // Stack widget to overlay the cart icon with a badge
    return Stack(
      children: [
        IconButton(
          iconSize: 38,
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            
    // Navigate to the cart page only if not already on the cart page
            if (currentRouteName != '/cart') {
              Navigator.pushNamed(context, '/cart');
            }
          },

    // Grey out the icon if on the cart page
          color: currentRouteName == '/cart' ? Colors.grey : null,
        ),
        if (cartItemCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: CartBadgeWidget(cartItemCount: cartItemCount),
          ),
      ],
    );
  },
);

  }
}

class CartBadgeWidget extends StatelessWidget {
  final int cartItemCount;

  const CartBadgeWidget({required this.cartItemCount});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.red,
      radius: 10,
      child: Text(
        cartItemCount.toString(),
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}



