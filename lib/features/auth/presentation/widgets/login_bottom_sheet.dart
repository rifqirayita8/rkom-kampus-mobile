import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rkom_kampus/features/auth/presentation/widgets/landing_page_widget.dart';
import 'package:rkom_kampus/gen/assets.gen.dart';
import 'package:rkom_kampus/gen/fonts.gen.dart';
import 'package:rkom_kampus/widgets/auth_bottom_sheet_header.dart';
import 'package:rkom_kampus/widgets/custom_elevated_button.dart';
import 'package:rkom_kampus/widgets/custom_text_button.dart';
import 'package:rkom_kampus/widgets/custom_textfield.dart';
import '../../../../utils/colors.dart';
import '../pages/coba.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> 
    with SingleTickerProviderStateMixin {

  late final AnimationController _animationController;
  late final Animation<Offset> _animation;
  final TextEditingController _nameEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation= Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        width: double.infinity,
        height: 400,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            ...authBottomSheetHeader(
              title1: 'Login', 
              title2: 'Your journey is finally here'
            ),
            Form(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoginView) {
                    return Column(
                      children: [
                        customTextField(
                          label: 'Username or Email', 
                          controller: _nameEmailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) {
                            context.read<AuthBloc>().add(AuthEmailChanged(val));
                          }
                        ),
                        const SizedBox(height: 10),
                        customTextField(
                          label: 'Enter your password', 
                          controller: _passwordController,
                          obscureText: state.isObscure,
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthToggleObscureText());
                            }, 
                            icon: SvgPicture.asset(
                              state.isObscure
                                ? Assets.images.common.eye
                                : Assets.images.common.eyeOff,
                            )
                          ),
                          onChanged: (val) {
                            context.read<AuthBloc>().add(AuthPasswordChanged(val));
                          }
                        ),
                        const SizedBox(height: 5),
                        customTextButton(
                          label1: '', 
                          label2: 'Forgot Password?', 
                          mainAxisAlignment: MainAxisAlignment.end,
                          isSpread: false,
                          onTap: () {}
                        ),
                        customElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthLogin(
                              email: state.email, 
                              password: state.password
                              )
                            );
                          }, 
                          label: 'Login'
                        ),
                        customTextButton(
                          label1: 'Don\'t have an account? ', 
                          label2: 'Sign Up', 
                          onTap: () {}
                        ),
                      ],
                    ); 
                  }
                  return const SizedBox.shrink();
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}