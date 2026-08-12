import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/user.dart';

sealed class LoginState extends Equatable {
const LoginState();

@override
List<Object?> get props => [];
}

class LoginInitial extends LoginState {
const LoginInitial();
}

class LoginLoading extends LoginState {
const LoginLoading();
}

class LoginSuccess extends LoginState {
final User user;

const LoginSuccess(this.user);

@override
List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
final Failure failure;

const LoginFailure(this.failure);

@override
List<Object?> get props => [failure];
}

