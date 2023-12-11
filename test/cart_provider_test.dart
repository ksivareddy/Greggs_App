import 'package:flutter_test/flutter_test.dart';
import 'package:greggs_app/provider/cart_provider.dart';
import 'package:greggs_app/model/product.dart';

void main() {
  group('CartProvider Tests', () {
    test('Initial cart count should be 0', () {
      final cartProvider = CartProvider();
      expect(cartProvider.cartCount, 0);
    });

    test('Adding an item to the cart should increase the count', () {
      final cartProvider = CartProvider();
      final testProduct = createTestProduct();

      cartProvider.addToCart(testProduct, 1, '');

      expect(cartProvider.cartCount, 1);
    });

  test('Removing an item from the cart should decrease the count', () {
      final cartProvider = CartProvider();
      final testProduct = createTestProduct();
      cartProvider.addToCart(testProduct, 3, ''); 
      cartProvider.decreaseCartItemQuantity(testProduct.articleCode, 1, '');
      expect(cartProvider.cartCount, 2);
    });

    test('Clearing the cart should set the count to 0', () {
      final cartProvider = CartProvider();
      final testProduct = createTestProduct();

      cartProvider.addToCart(testProduct, 3, ''); 
      cartProvider.clearCart();

      expect(cartProvider.cartCount, 0);
    });

 // Modify the test for checking total price as follows
test('Total price should be correct', () {
  final cartProvider = CartProvider();
  final testProduct1 = createTestProduct();
  final testProduct2 = createTestProduct();

  cartProvider.addToCart(testProduct1, 2, '');
  cartProvider.addToCart(testProduct2, 1, '');

  // Round to two decimal places for better precision
  final expectedTotalPrice = 3.45.toStringAsFixed(2);
  final actualTotalPrice = cartProvider.totalPrice.toStringAsFixed(2);

  expect(actualTotalPrice, equals(expectedTotalPrice));
});

  });
}

Product createTestProduct() {
  return Product(
    articleCode: '1000447',
    shopCode: '1234',
    availableFrom: DateTime.parse("2022-01-01T00:00:00Z"),
    availableUntil: DateTime.parse("2045-05-13T23:59:59Z"),
    eatOutPrice: 1.05,
    eatInPrice: 1.15,
    articleName: 'Chicken Roll',
    dayParts: ['Breakfast', 'Lunch', 'Evening'],
    internalDescription: 'Chicken Sausage Roll',
    customerDescription:
        'Delicious chicken sausage roll with a blend of spices. Perfect for any time of the day.',
    imageUri:
        'https://images.ctfassets.net/pjshm78m9jt4/292426_header/f4ca7b9a88202b32c668746d52d98560/importedImage292426_header',
    thumbnailUri:
        'https://images.ctfassets.net/pjshm78m9jt4/292426_header/f4ca7b9a88202b32c668746d52d98560/importedImage292426_header',
  );
}
