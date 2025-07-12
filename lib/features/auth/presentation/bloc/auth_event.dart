part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthRegister extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  const AuthRegister({ required this.fullName, required this.email, required this.password});

  @override
  List<Object> get props => [fullName, email, password];
}

final class AuthEmailLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEmailLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthEmailRegister extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  const AuthEmailRegister({required this.fullName ,required this.email, required this.password});

  @override
  List<Object> get props => [fullName ,email, password];
}

final class AuthReset extends AuthEvent {
  const AuthReset();

  @override
  List<Object> get props => [];
}