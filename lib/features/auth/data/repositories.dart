
import '../domain/entities.dart';
import '../domain/repositories.dart';
import 'datasources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<LoginResultEntity> login({
    required String email,
    required String password,
  }) {
    return dataSource.login(
      email: email,
      password: password,
    );
  }
}
