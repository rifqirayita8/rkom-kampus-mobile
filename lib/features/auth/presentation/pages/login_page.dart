import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_view_cubit.dart';
import 'package:rkom_kampus/features/auth/presentation/widgets/landing_page_widget.dart';
import 'package:rkom_kampus/features/auth/presentation/widgets/login_bottom_sheet.dart';
import 'package:rkom_kampus/features/homepage/presentation/pages/homepage.dart';
import 'package:rkom_kampus/gen/assets.gen.dart';

import '../widgets/register_bottom_sheet.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state= context.watch<AuthBloc>().state;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.images.auth.bgKampusPng,
              fit: BoxFit.fill,
            )
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Homepage())
                );
              }
            },
            child: const SizedBox.shrink(),
          ),
          BlocBuilder<AuthViewCubit, AuthView>(
            builder: (context, viewState) {
              switch (viewState) {
                case AuthView.landing:
                  return const LandingPageWidget();
                case AuthView.login:
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: const LoginBottomSheet());
                case AuthView.register:
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: const RegisterBottomSheet(),
                  );
              }
            }
          ),
          if (state is AuthLoading) ...[
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
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