import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rkom_kampus/features/auth/domain/usecases/user_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin userLogin;
  
  AuthBloc({
    required this.userLogin
    }) : super(const AuthLandingView()) {

    on<AuthShowLogin>((event, emit) async {
      emit(const AuthLoginView());
    });

    on<AuthShowRegister>((event, emit) async {
      emit(const AuthRegisterView());
    });

    on<AuthEmailChanged>((event, emit) {
      if (state is AuthLoginView) {
        emit((state as AuthLoginView).copyWith(email: event.email));
      }
    });

    on<AuthPasswordChanged>((event, emit) {
      if (state is AuthLoginView) {
        emit((state as AuthLoginView).copyWith(password: event.password));
      }
    });

    on<AuthToggleObscureText>((event, emit) {
      if (state is AuthLoginView) {
        final current= state as AuthLoginView;
        emit(current.copyWith(isObscure: !current.isObscure));
      }
    });

    on<AuthLogin>((event, emit) async {

      emit(const AuthLoading());
      await Future.delayed(const Duration(milliseconds: 500));

      final response= await userLogin.execute(
        event.email, 
        event.password, 
      );

      response.fold(
        (failure) {
          emit(AuthFailure(message: failure.message));
          print('Login failed: ${failure.message}');
        }, 
        (message) {
          emit(AuthSuccess(message: message));
          print('Login successful: $message');
        }
      );
    });
  } 
}
