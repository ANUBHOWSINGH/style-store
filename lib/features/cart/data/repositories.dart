
import '../../products/domain/entities.dart';
import '../domain/entities.dart';
import '../domain/repositories.dart';
import 'datasources.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource dataSource;

  CartRepositoryImpl({required this.dataSource});

  @override
  CartEntity getCart() => dataSource.getCart();

  @override
  void addToCart(ProductEntity product) {
    dataSource.add(product);
  }

  @override
  void removeFromCart(String productId) {
    dataSource.remove(productId);
  }

  @override
  void updateQuantity(String productId, int quantity) {
    dataSource.updateQuantity(productId, quantity);
  }

  @override
  void clearCart() {
    dataSource.clear();
  }
}
