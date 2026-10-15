// The use case represents the business operation of retrieving products.
import 'entities.dart';
import 'repositories.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getProducts();
  }
}
