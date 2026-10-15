
import '../../products/domain/entities.dart';
import '../domain/entities.dart';

abstract class CartLocalDataSource {
  CartEntity getCart();

  void add(ProductEntity product);

  void remove(String productId);

  void updateQuantity(String productId, int quantity);

  void clear();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Map<String, CartItemEntity> _items = {};

  @override
  CartEntity getCart() {
    return CartEntity(
      items: List.unmodifiable(_items.values),
    );
  }

  @override
  void add(ProductEntity product) {
    final existing = _items[product.id];

    if (existing == null) {
      _items[product.id] = CartItemEntity(
        product: product,
        quantity: 1,
      );
    } else {
      _items[product.id] = existing.copyWith(
        quantity: existing.quantity + 1,
      );
    }
  }

  @override
  void remove(String productId) {
    _items.remove(productId);
  }

  @override
  void updateQuantity(String productId, int quantity) {
    if (!_items.containsKey(productId)) return;

    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      _items[productId] =
          _items[productId]!.copyWith(quantity: quantity);
    }
  }

  @override
  void clear() {
    _items.clear();
  }
}
