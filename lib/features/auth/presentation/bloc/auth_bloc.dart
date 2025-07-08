import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rkom_kampus/features/auth/domain/usecases/user_login.dart';
import 'package:rkom_kampus/features/auth/domain/usecases/user_register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin userLogin;
  final UserRegister userRegister;
  
  AuthBloc({
    required this.userLogin,
    required this.userRegister,
    }) : super(const AuthInitial()) {

    on<AuthReset>((event, emit) {
      emit(const AuthInitial());
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

    on<AuthRegister>((event, emit) async {

      emit(const AuthLoading());
      await Future.delayed(const Duration(milliseconds: 500));

      final response= await userRegister.execute(
        event.fullName, 
        event.email, 
        event.password, 
      );

      response.fold(
        (failure) {
          emit(AuthFailure(message: failure.message));
          print('Register failed: ${failure.message}');
        }, 
        (message) {
          emit(AuthSuccess(message: message));
          print('Register successful: $message');
        }
      );
    });
  } 
}
