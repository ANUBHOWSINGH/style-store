
import '../domain/entities.dart';

abstract class AuthLocalDataSource {
  Future<LoginResultEntity> login({
    required String email,
    required String password,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String demoEmail = 'demo@stylestore.com';
  static const String demoPassword = 'Style@123';

  @override
  Future<LoginResultEntity> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    if (email.trim().toLowerCase() != demoEmail ||
        password != demoPassword) {
      throw Exception('Invalid email or password.');
    }

    return LoginResultEntity(email: email.trim().toLowerCase());
  }
}
