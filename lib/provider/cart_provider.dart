import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../model/cart_item.dart';
import '../model/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Method to add a product to the cart with a specific quantity and variant
  void addToCart(Product product, int quantity, String selectedVariant) {
    var existingCartItem = _cartItems.firstWhereOrNull(
      (item) => item.product.articleCode == product.articleCode,
    );

    if (existingCartItem != null) {
      existingCartItem.quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }

    // Notify listeners that the state has changed
    notifyListeners();
  }

  // Method to get the quantity of a specific product in the cart
  int getProductQuantity(String articleCode) {
    int quantity = 0;
    for (CartItem item in _cartItems) {
      if (item.product.articleCode == articleCode) {
        quantity += item.quantity;
      }
    }
    return quantity;
  }

  // Getter for the total number of items in the cart
  int get cartCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Getter for the total price of items in the cart
  double get totalPrice {
    return _cartItems.fold(
        0.0, (sum, item) => sum + (item.product.eatInPrice * item.quantity));
  }

  // Method to update the quantity of a specific product in the cart
  void updateCartItemQuantity(String articleCode, int newQuantity) {
    final index = _cartItems.indexWhere(
      (item) => item.product.articleCode == articleCode,
    );

    if (index != -1) {
      _cartItems[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  // Method to increase the quantity of a specific product in the cart
  void increaseCartItemQuantity(String articleCode, int i, String s) {
    final index = _cartItems.indexWhere(
      (item) => item.product.articleCode == articleCode,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  // Method to decrease the quantity of a specific product in the cart
  void decreaseCartItemQuantity(String articleCode, int i, String s) {
    final index = _cartItems.indexWhere(
      (item) => item.product.articleCode == articleCode,
    );

    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
        notifyListeners();
      } else {
        // If the quantity is 1, remove the item from the cart
        _cartItems.removeAt(index);
        notifyListeners();
      }
    }
  }

  // Method to remove a specific product from the cart
  void removeCartItem(String articleCode, int i) {
    _cartItems.removeWhere((item) => item.product.articleCode == articleCode);
    notifyListeners();
  }

  // Method to clear all items from the cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Method to get a copy of the cart items list
  List<CartItem> getCartItemsList() {
    return List<CartItem>.from(_cartItems);
  }
}
