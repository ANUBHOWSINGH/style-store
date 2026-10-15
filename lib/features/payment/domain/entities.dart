
import 'package:equatable/equatable.dart';

class PaymentResultEntity extends Equatable {
  final String orderId;
  final double paidAmount;

  const PaymentResultEntity({
    required this.orderId,
    required this.paidAmount,
  });

  @override
  List<Object?> get props => [orderId, paidAmount];
}
