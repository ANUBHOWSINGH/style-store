
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities.dart';
import '../domain/usecases.dart';

// Events
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

// States
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginFormState extends LoginState {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final String? errorMessage;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  bool get canSubmit =>
      isEmailValid && isPasswordValid && !isSubmitting;

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isEmailValid,
    isPasswordValid,
    isSubmitting,
    errorMessage,
  ];
}

class LoginSuccess extends LoginState {
  final LoginResultEntity result;

  const LoginSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase})
      : super(const LoginFormState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email.trim());
  }

  bool _isValidPassword(String password) {
    return password.trim().isNotEmpty;
  }

  void _onEmailChanged(
      LoginEmailChanged event,
      Emitter<LoginState> emit,
      ) {
    final current = state;
    if (current is! LoginFormState) return;

    emit(current.copyWith(
      email: event.email,
      isEmailValid: _isValidEmail(event.email),
      clearError: true,
    ));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    final current = state;
    if (current is! LoginFormState) return;

    emit(current.copyWith(
      password: event.password,
      isPasswordValid: _isValidPassword(event.password),
      clearError: true,
    ));
  }

  Future<void> _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    final current = state;
    if (current is! LoginFormState || !current.canSubmit) return;

    emit(current.copyWith(isSubmitting: true, clearError: true));

    try {
      final result = await loginUseCase(
        email: current.email,
        password: current.password,
      );

      emit(LoginSuccess(result));
    } catch (_) {
      emit(current.copyWith(
        isSubmitting: false,
        errorMessage: 'Invalid email or password.',
      ));
    }
  }
}
