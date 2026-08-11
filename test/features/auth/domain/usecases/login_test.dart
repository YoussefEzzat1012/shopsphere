import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopsphere/core/errors/server_failure.dart';
import 'package:shopsphere/core/result/result.dart';
import 'package:shopsphere/features/auth/domain/entities/user.dart';
import 'package:shopsphere/features/auth/domain/repositories/auth_repository.dart';
import 'package:shopsphere/features/auth/domain/usecases/login.dart';


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

  test('should return failure when login fails', () async {
    const failure = ServerFailure('Invalid credentials');

    when(
          () => repository.login(
        email: 'ahmed@example.com',
        password: 'wrong-password',
      ),
    ).thenAnswer(
          (_) async => const Result.failure(failure),
    );

    final result = await login(
      email: 'ahmed@example.com',
      password: 'wrong-password',
    );

    expect(result.isFailure, true);
    expect(result.failure, failure);

    verify(
          () => repository.login(
        email: 'ahmed@example.com',
        password: 'wrong-password',
      ),
    ).called(1);
  });
}