
import 'package:flutter_test/flutter_test.dart';
import 'package:style_store/features/cart/domain/entities.dart';
import 'package:style_store/features/products/domain/entities.dart';

void main() {
  group('CartEntity tests', () {
    const product = ProductEntity(
      id: '1',
      name: 'Classic T-Shirt',
      subtitle: 'Cotton T-Shirt',
      price: 500,
      imageUrl: 'https://example.com/tshirt.jpg',
      category: 'T-Shirts',
    );

    test('calculates total and quantity correctly', () {
      const cart = CartEntity(
        items: [
          CartItemEntity(product: product, quantity: 2),
        ],
      );

      expect(cart.totalAmount, 1000);
      expect(cart.totalItems, 2);
      expect(cart.isEmpty, false);
    });

    test('empty cart has zero total and quantity', () {
      const cart = CartEntity();

      expect(cart.totalAmount, 0);
      expect(cart.totalItems, 0);
      expect(cart.isEmpty, true);
    });
  });
}
