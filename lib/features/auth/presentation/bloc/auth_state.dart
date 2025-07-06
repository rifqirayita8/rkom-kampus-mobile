part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();  

  @override
  List<Object> get props => [];
}
final class AuthLandingView extends AuthState {
  const AuthLandingView();

  @override
  List<Object> get props => [];
}

final class AuthLoginView extends AuthState {
  const AuthLoginView();

  @override
  List<Object> get props => [];
}

final class AuthRegisterView extends AuthState {
  const AuthRegisterView();

  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object> get props => [];
}

final class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
