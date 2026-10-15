// repository contract to the local data source.
import '../../products/domain/entities.dart';
import '../domain/repositories.dart';
import 'datasources.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource dataSource;

  WatchlistRepositoryImpl({required this.dataSource});

  @override
  List<ProductEntity> getWatchlist() {
    return dataSource.getWatchlist();
  }

  @override
  void addToWatchlist(ProductEntity product) {
    dataSource.add(product);
  }

  @override
  void removeFromWatchlist(String productId) {
    dataSource.remove(productId);
  }
}
