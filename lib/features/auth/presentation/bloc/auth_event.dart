part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthShowLogin extends AuthEvent {}

final class AuthShowRegister extends AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthRegister({ required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}

final class AuthEmailChanged extends AuthEvent {
  final String email;
  const AuthEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

final class AuthPasswordChanged extends AuthEvent {
  final String password;
  const AuthPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

final class AuthToggleObscureText extends AuthEvent {}
