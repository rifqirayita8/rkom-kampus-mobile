part of 'init_injection_imports.dart';

var myInjection= GetIt.instance;

Future<void> initInjection() async {

  myInjection.registerLazySingleton(
    () => Dio()
  );

  myInjection.registerFactory(
    () => AuthBloc(
      userLogin: myInjection(),
      userRegister: myInjection(),
    ),
  );

  myInjection.registerLazySingleton(
    () => UserLogin(authRepository: myInjection()),
  );

  myInjection.registerLazySingleton(
    () => UserRegister(authRepository: myInjection()),
  );

  myInjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: myInjection()),
  );

  myInjection.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dio: myInjection())
  );

  myInjection.registerFactory<AuthViewCubit>(
    () => AuthViewCubit(),
  );

  myInjection.registerFactory<AuthFormCubit>(
    () => AuthFormCubit(),
  );
}