
import 'package:equatable/equatable.dart';

class LoginResultEntity extends Equatable {
  final String email;

  const LoginResultEntity({required this.email});

  @override
  List<Object?> get props => [email];
}
