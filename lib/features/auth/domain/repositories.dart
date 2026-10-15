
import 'entities.dart';

abstract class AuthRepository {
  Future<LoginResultEntity> login({
    required String email,
    required String password,
  });
}
