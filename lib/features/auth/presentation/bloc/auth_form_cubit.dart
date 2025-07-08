import 'package:flutter_bloc/flutter_bloc.dart';

class AuthFormState {
  final String email;
  final String password;
  final bool isObscure;

  const AuthFormState({
    this.email = '',
    this.password = '',
    this.isObscure = true,
  });
  
  AuthFormState copyWith({
    String? email,
    String? password,
    bool? isObscure,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}

class AuthFormCubit extends Cubit<AuthFormState>{
  AuthFormCubit() :super(const AuthFormState());

  void updateEmail(String val) => emit(state.copyWith(email: val));
  void updatePassword(String val) => emit(state.copyWith(password: val));
  void toggleObscureText() => emit(state.copyWith(isObscure: !state.isObscure));
}