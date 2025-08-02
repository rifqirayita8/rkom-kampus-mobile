import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_form_cubit.dart';
import 'package:rkom_kampus/features/auth/presentation/widgets/landing_page_widget.dart';
import 'package:rkom_kampus/gen/assets.gen.dart';
import 'package:rkom_kampus/gen/fonts.gen.dart';
import 'package:rkom_kampus/widgets/auth_bottom_sheet_header.dart';
import 'package:rkom_kampus/widgets/custom_elevated_button.dart';
import 'package:rkom_kampus/widgets/custom_text_button.dart';
import 'package:rkom_kampus/widgets/custom_textfield.dart';
import '../../../../utils/colors.dart';
import '../bloc/auth_view_cubit.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> 
    with SingleTickerProviderStateMixin {

  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

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
      child: SafeArea(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...authBottomSheetHeader(
                    title1: 'Login', 
                    title2: 'Your journey is finally here'
                  ),
                  Form(
                    child: BlocBuilder<AuthFormCubit, AuthFormState>(
                      builder: (context, formState) {
                        return Column(
                          children: [
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthFailure) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      border: Border.all(color: Colors.red.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.error_outline, color: Colors.red.shade400),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            state.message,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                              fontFamily: FontFamily.montserratRegular,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }

                              }
                            ),
                            customTextField(
                              label: 'Username or Email', 
                              initialValue: formState.email,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) {
                                context.read<AuthFormCubit>().updateEmail(val);
                              }
                            ),
                            const SizedBox(height: 10),
                            customTextField(
                              label: 'Enter your password', 
                              initialValue: formState.password,
                              obscureText: formState.isObscure,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<AuthFormCubit>().toggleObscureText();
                                }, 
                                icon: SvgPicture.asset(
                                  formState.isObscure
                                    ? Assets.images.common.eye
                                    : Assets.images.common.eyeOff,
                                )
                              ),
                              onChanged: (val) {
                                context.read<AuthFormCubit>().updatePassword(val);
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

                              }, 
                              label: 'Login'
                            ),
                            customElevatedButton(
                              onPressed: () {
                                // context.read<AuthBloc>().add(AuthLogin(
                                //   email: formState.email.trim(), 
                                //   password: formState.password.trim()
                                //   )
                                // );
                                context.read<AuthBloc>().add(AuthEmailLogin(
                                  email: formState.email.trim(), 
                                  password: formState.password.trim()
                                ));
                                context.read<AuthFormCubit>().reset();
                              }, 
                              label: 'Login with Google'
                            ),
                            const SizedBox(height: 10),
                            customTextButton(
                              label1: 'Don\'t have an account? ', 
                              label2: 'Sign Up', 
                              onTap: () {
                                context.read<AuthFormCubit>().reset();
                                context.read<AuthBloc>().add(const AuthReset());
                                context.read<AuthViewCubit>().showRegister();
                              }
                            ),
                          ],
                        ); 
                      },
                    )
                  ),
                  Padding(padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}