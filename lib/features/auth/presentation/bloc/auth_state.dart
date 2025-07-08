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
  final String email;
  final String password;
  final bool isObscure;

  const AuthLoginView({
    this.email = '',
    this.password = '',
    this.isObscure = true,
  });

  AuthLoginView copyWith({
    String? email,
    String? password,
    bool? isObscure,
  }) {
    return AuthLoginView(
      email: email ?? this.email,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object> get props => [email, password, isObscure];
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

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}
