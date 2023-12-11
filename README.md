# greggs_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



App Functionality:

Home Screen (home.dart):
Displays a grid of products, each represented by a ProductGridItem.
Products are loaded from a list of Product instances, which include details such as article code, shop code, prices, availability, and descriptions.
Tapping on a product navigates to the SausageRollDetailPage for detailed information.

Product Detail Screen (sausage_roll_detail_screen.dart):
Shows detailed information about a specific product, including its availability status.
Users can add the product to the shopping cart from this screen.
Includes an "Add to Cart" button, which triggers the addition of the product to the cart using the CartProvider.

Shopping Cart (cart_details.dart):
Accessed via the cart icon in the app bar.
Displays a list of items in the shopping cart using the CartItemList component.
The Cart Summary Section shows the total price of items in the cart.
Users can clear the entire cart using the "Clear Cart" button.
Provides a "Checkout" button to handle the checkout process (the implementation is yet to be added).

Common App Bar (common_appbar.dart):
Displays a consistent app bar across screens.
Includes a logo, page title, and a shopping cart icon with a badge indicating the number of items in the cart.

App Special Features:

State Management:
Utilizes the Provider package for state management, specifically the ChangeNotifierProvider for managing the shopping cart state.

Navigation:
Uses MaterialPageRoute for navigation between screens.
The app bar includes a consistent navigation structure with a logo, page title, and a shopping cart icon.

Shopping Cart Integration:
The CartProvider class manages the shopping cart state, allowing for the addition, removal, and clearing of items.
The app visually communicates the number of items in the cart using a badge on the shopping cart icon.

Product Display:
The app dynamically displays products in a grid on the home screen.
Each product is represented by a ProductGridItem widget.

Product Detail View:
The SausageRollDetailPage provides detailed information about a specific product, including its availability status.

