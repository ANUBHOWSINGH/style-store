
import 'entities.dart';

abstract class PaymentRepository {
  Future<PaymentResultEntity> processPayment(double amount);
}
