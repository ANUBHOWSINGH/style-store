
import '../domain/entities.dart';
import '../domain/repositories.dart';
import 'datasources.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      return await localDataSource.getProducts();
    } catch (error) {
      throw Exception('Failed to load products: $error');
    }
  }
}
