import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthView { landing, login, register }

class AuthViewCubit extends Cubit<AuthView> {
  AuthViewCubit() : super(AuthView.landing);

  void showLanding() => emit(AuthView.landing);
  void showLogin() => emit(AuthView.login);
  void showRegister() => emit(AuthView.register);
}