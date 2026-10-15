
import '../../products/domain/entities.dart';

abstract class WatchlistLocalDataSource {
  List<ProductEntity> getWatchlist();

  void add(ProductEntity product);

  void remove(String productId);
}

class WatchlistLocalDataSourceImpl
    implements WatchlistLocalDataSource {
  final Map<String, ProductEntity> _items = {};

  @override
  List<ProductEntity> getWatchlist() =>
      List.unmodifiable(_items.values);

  @override
  void add(ProductEntity product) {
    _items[product.id] = product;
  }

  @override
  void remove(String productId) {
    _items.remove(productId);
  }
}
