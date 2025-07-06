import 'package:flutter/material.dart';
import 'package:rkom_kampus/features/auth/presentation/pages/login_page.dart';

class AppRoutes {
  // static const String initial = '/';
  static const String landingPage= '/'; 

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.landingPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginPage()
        );
        
        default:
        return _errorRoute(settings);
    }
  }

  static MaterialPageRoute _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(
            'Error: ${settings.name}',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      )
    );
  }
}