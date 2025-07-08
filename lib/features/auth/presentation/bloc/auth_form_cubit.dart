import 'package:flutter_bloc/flutter_bloc.dart';

class AuthFormState {
  final String fullName;
  final String email;
  final String password;
  final bool isObscure;

  const AuthFormState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.isObscure = true,
  });
  
  AuthFormState copyWith({
    String? fullName,
    String? email,
    String? password,
    bool? isObscure,
  }) {
    return AuthFormState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}

class AuthFormCubit extends Cubit<AuthFormState>{
  AuthFormCubit() :super(const AuthFormState());

  void updateFullName(String val) => emit(state.copyWith(fullName: val));
  void updateEmail(String val) => emit(state.copyWith(email: val));
  void updatePassword(String val) => emit(state.copyWith(password: val));
  void toggleObscureText() => emit(state.copyWith(isObscure: !state.isObscure));

  void reset() => emit(const AuthFormState());
}