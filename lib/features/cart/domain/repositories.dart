
import '../../products/domain/entities.dart';
import 'entities.dart';

abstract class CartRepository {
  CartEntity getCart();

  void addToCart(ProductEntity product);

  void removeFromCart(String productId);

  void updateQuantity(String productId, int quantity);

  void clearCart();
}
