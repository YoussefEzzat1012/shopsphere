import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


import '../../../../core/result/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import 'login.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late Login login;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    login = Login(repository);
  });

  test('should return user when login succeeds', () async {
    const user = User(
      id: 1,
      name: 'Ahmed Ali',
      email: 'ahmed@example.com',
    );

    when(
          () => repository.login(
        email: 'ahmed@example.com',
        password: '123456',
      ),
    ).thenAnswer(
          (_) async => const Result.success(user),
    );

    final result = await login(
      email: 'ahmed@example.com',
      password: '123456',
    );

    expect(result.isSuccess, true);
    expect(result.data, user);

    verify(
          () => repository.login(
        email: 'ahmed@example.com',
        password: '123456',
      ),
    ).called(1);
  });
}