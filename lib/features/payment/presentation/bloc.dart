
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities.dart';
import '../domain/usecases.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class InitiatePayment extends PaymentEvent {
  final double amount;

  const InitiatePayment(this.amount);

  @override
  List<Object?> get props => [amount];
}

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSuccess extends PaymentState {
  final PaymentResultEntity result;

  const PaymentSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class PaymentFailure extends PaymentState {
  final String message;

  const PaymentFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ProcessDummyPaymentUseCase processDummyPayment;

  PaymentBloc({required this.processDummyPayment})
      : super(const PaymentInitial()) {
    on<InitiatePayment>(_onInitiatePayment);
  }

  Future<void> _onInitiatePayment(
      InitiatePayment event,
      Emitter<PaymentState> emit,
      ) async {
    emit(const PaymentLoading());

    try {
      final result = await processDummyPayment(event.amount);
      emit(PaymentSuccess(result));
    } catch (_) {
      emit(
        const PaymentFailure(
          'Payment could not be processed. Please try again.',
        ),
      );
    }
  }
}
