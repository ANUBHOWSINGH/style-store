
import '../domain/entities.dart';
import '../domain/repositories.dart';
import 'datasources.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentLocalDataSource dataSource;

  PaymentRepositoryImpl({required this.dataSource});

  @override
  Future<PaymentResultEntity> processPayment(double amount) {
    return dataSource.processPayment(amount);
  }
}
