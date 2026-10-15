
import 'entities.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
}
