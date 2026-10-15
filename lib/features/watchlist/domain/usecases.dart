
import '../../products/domain/entities.dart';
import 'repositories.dart';

class GetWatchlistUseCase {
  final WatchlistRepository repository;

  GetWatchlistUseCase(this.repository);

  List<ProductEntity> call() => repository.getWatchlist();
}

class AddToWatchlistUseCase {
  final WatchlistRepository repository;

  AddToWatchlistUseCase(this.repository);

  void call(ProductEntity product) {
    repository.addToWatchlist(product);
  }
}

class RemoveFromWatchlistUseCase {
  final WatchlistRepository repository;

  RemoveFromWatchlistUseCase(this.repository);

  void call(String productId) {
    repository.removeFromWatchlist(productId);
  }
}
