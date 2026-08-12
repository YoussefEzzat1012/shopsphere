import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopsphere/core/errors/server_failure.dart';
import 'package:shopsphere/core/result/result.dart';
import 'package:shopsphere/features/auth/domain/entities/user.dart';
import 'package:shopsphere/features/auth/domain/usecases/login.dart';
import 'package:shopsphere/features/auth/presentation/cubit/login_cubit.dart';
import 'package:shopsphere/features/auth/presentation/cubit/login_state.dart';

class MockLogin extends Mock implements Login {}

void main() {
  late MockLogin login;

  setUp(() {
      login = MockLogin();
  });

  blocTest<LoginCubit, LoginState>(
    'should emit [Loading, Success] when login succeeds',
    build: () {
      const user = User(
      id: 1,
      name: 'Ahmed Ali',
      email: 'ahmed@example.com',
  );

  when(
    () => login(
    email: 'ahmed@example.com',
    password: '123456',
    ),
    ).thenAnswer(
    (_) async => const Result.success(user),
    );

    return LoginCubit(login);
  },
    act: (cubit) => cubit.loginUser(
    email: 'ahmed@example.com',
    password: '123456',
  ),
    expect: () => [
    const LoginLoading(),
    const LoginSuccess(
    User(
    id: 1,
    name: 'Ahmed Ali',
    email: 'ahmed@example.com',
    ),
    ),
    ],
    );


  blocTest<LoginCubit, LoginState>(
    'should emit [Loading, Failure] when login fails',
    build: () {
      const failure = ServerFailure('Invalid credentials');

      when(
            () => login(
          email: 'ahmed@example.com',
          password: 'wrong-password',
        ),
      ).thenAnswer(
            (_) async => const Result.failure(failure),
      );

      return LoginCubit(login);
    },
    act: (cubit) => cubit.loginUser(
      email: 'ahmed@example.com',
      password: 'wrong-password',
    ),
    expect: () => [
      const LoginLoading(),
      const LoginFailure(
        ServerFailure('Invalid credentials'),
      ),
    ],
  );
}
