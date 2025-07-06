import 'package:get_it/get_it.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';

var myInjection= GetIt.instance;

Future<void> initInjection() async {
  myInjection.registerFactory(
    () => AuthBloc(
      
    ),
  );
}