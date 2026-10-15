
import 'package:flutter_test/flutter_test.dart';
import 'package:style_store/features/products/domain/entities.dart';
import 'package:style_store/features/watchlist/data/datasources.dart';

void main() {
  group('Watchlist data source tests', () {
    late WatchlistLocalDataSourceImpl dataSource;

    const product = ProductEntity(
      id: '1',
      name: 'Classic T-Shirt',
      subtitle: 'Cotton T-Shirt',
      price: 500,
      imageUrl: 'https://example.com/tshirt.jpg',
      category: 'T-Shirts',
    );

    setUp(() {
      dataSource = WatchlistLocalDataSourceImpl();
    });

    test('adds a product to the watchlist', () {
      dataSource.add(product);

      expect(dataSource.getWatchlist(), hasLength(1));
      expect(dataSource.getWatchlist().first.id, '1');
    });

    test('removes a product from the watchlist', () {
      dataSource.add(product);
      dataSource.remove(product.id);

      expect(dataSource.getWatchlist(), isEmpty);
    });
  });
}
