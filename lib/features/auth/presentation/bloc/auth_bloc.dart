import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLandingView()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLandingView());
    });

    on<AuthLogin>((event, emit) async {
      emit(AuthLoginView());
    });

    on<AuthRegister>((event, emit) async {
      emit(AuthRegisterView());
    });
  } 
}
