
import 'package:uuid/uuid.dart';

import '../domain/entities.dart';

abstract class PaymentLocalDataSource {
  Future<PaymentResultEntity> processPayment(double amount);
}

class PaymentLocalDataSourceImpl implements PaymentLocalDataSource {
  final Uuid _uuid = const Uuid();

  @override
  Future<PaymentResultEntity> processPayment(double amount) async {
    if (!amount.isFinite || amount <= 0) {
      throw ArgumentError('Payment amount must be greater than zero.');
    }

    await Future<void>.delayed(
      const Duration(seconds: 2),
    );

    return PaymentResultEntity(
      orderId: 'SS-${_uuid.v4().substring(0, 8).toUpperCase()}',
      paidAmount: amount,
    );
  }
}
