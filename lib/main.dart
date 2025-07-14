import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rkom_kampus/core/observer.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rkom_kampus/features/auth/presentation/pages/coba.dart';
import 'package:rkom_kampus/features/auth/presentation/pages/login_page.dart';
import 'package:rkom_kampus/firebase_options.dart';
import 'package:rkom_kampus/gen/fonts.gen.dart';
import 'package:rkom_kampus/utils/routes.dart';

import 'core/di/init_injection_imports.dart';
import 'features/auth/presentation/bloc/auth_form_cubit.dart';
import 'features/auth/presentation/bloc/auth_view_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initInjection();
  Bloc.observer= MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => myInjection<AuthBloc>()
        ),
        BlocProvider(
          create: (context) => myInjection<AuthViewCubit>() 
        ),
        BlocProvider(
          create: (context) => myInjection<AuthFormCubit>()
        )
      ],
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //return const LoginPage();
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a purple toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: FontFamily.montserratRegular,
            ),
            initialRoute: asyncSnapshot.data != null 
              ? AppRoutes.homePage
              : AppRoutes.landingPage,
            onGenerateRoute: AppRoutes.generateRoute,
            debugShowCheckedModeBanner: false,
            // home: LoginPage()
          );
        }
      ),
    );
  }
}
