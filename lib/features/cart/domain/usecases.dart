
import '../../products/domain/entities.dart';
import 'entities.dart';
import 'repositories.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  CartEntity call() => repository.getCart();
}

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  void call(ProductEntity product) {
    repository.addToCart(product);
  }
}

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  void call(String productId) {
    repository.removeFromCart(productId);
  }
}

class UpdateCartQuantityUseCase {
  final CartRepository repository;

  UpdateCartQuantityUseCase(this.repository);

  void call(String productId, int quantity) {
    repository.updateQuantity(productId, quantity);
  }
}

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  void call() {
    repository.clearCart();
  }
}
