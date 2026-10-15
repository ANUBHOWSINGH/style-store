
import 'package:flutter_test/flutter_test.dart';
import 'package:style_store/features/auth/data/datasources.dart';

void main() {
  late AuthLocalDataSourceImpl dataSource;

  setUp(() {
    dataSource = AuthLocalDataSourceImpl();
  });

  test('accepts correct demo credentials', () async {
    final result = await dataSource.login(
      email: 'demo@stylestore.com',
      password: 'Style@123',
    );

    expect(result.email, 'demo@stylestore.com');
  });

  test('rejects incorrect demo credentials', () async {
    await expectLater(
      dataSource.login(
        email: 'wrong@example.com',
        password: 'wrong-password',
      ),
      throwsA(isA<Exception>()),
    );
  });
}
