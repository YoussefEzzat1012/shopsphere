import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login login;

  LoginCubit(this.login) : super(const LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());

    final result = await login(
      email: email,
      password: password,
    );

    if (result.isSuccess) {
      emit(LoginSuccess(result.data!));
    } else {
      emit(LoginFailure(result.failure!));
    }
  }
}