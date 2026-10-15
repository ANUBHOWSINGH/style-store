
import '../../products/domain/entities.dart';

abstract class WatchlistRepository {
  List<ProductEntity> getWatchlist();

  void addToWatchlist(ProductEntity product);

  void removeFromWatchlist(String productId);
}
