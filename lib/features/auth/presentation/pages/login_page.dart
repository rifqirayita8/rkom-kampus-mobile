import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rkom_kampus/features/auth/presentation/widgets/landing_page_widget.dart';
import 'package:rkom_kampus/features/auth/presentation/widgets/login_bottom_sheet.dart';
import 'package:rkom_kampus/gen/assets.gen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.images.auth.bgKampusPng,
              fit: BoxFit.fill,
            )
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLandingView) {
                return const LandingPageWidget();
              } else if (state is AuthLoginView) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: const LoginBottomSheet());
              } else if (state is AuthRegisterView) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Register View', 
                        style: TextStyle(
                          fontSize: 96 
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is AuthLoading) {
                return CircularProgressIndicator();
              }
              return Container();
            }
          ),
        ],
      ),
    );
  }
}