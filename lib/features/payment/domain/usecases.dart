
import 'entities.dart';
import 'repositories.dart';

class ProcessDummyPaymentUseCase {
  final PaymentRepository repository;

  ProcessDummyPaymentUseCase(this.repository);

  Future<PaymentResultEntity> call(double amount) {
    return repository.processPayment(amount);
  }
}
