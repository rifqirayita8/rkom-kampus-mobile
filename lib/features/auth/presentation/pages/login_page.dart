import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rkom_kampus/features/auth/presentation/widgets/landing_page_widget.dart';
import 'package:rkom_kampus/features/auth/presentation/widgets/login_bottom_sheet.dart';
import 'package:rkom_kampus/gen/assets.gen.dart';

import 'coba.dart';

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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Coba()));
              }
            },
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
              } 
              return const SizedBox.shrink();
            }
          ),
          if (context.watch<AuthBloc>().state is AuthLoading) ...[
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            ),
          ]
        ],
      ),
    );
  }
}