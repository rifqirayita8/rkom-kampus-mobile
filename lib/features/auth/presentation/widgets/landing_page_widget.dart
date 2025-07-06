import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rkom_kampus/gen/fonts.gen.dart';
import 'package:rkom_kampus/utils/colors.dart';
import 'package:rkom_kampus/widgets/custom_elevated_button.dart';
import 'package:rkom_kampus/widgets/custom_text_button.dart';

class LandingPageWidget extends StatelessWidget {
  const LandingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          const Spacer(flex: 2),
          const Expanded(
            child: Text(
              'Everything you need to know about university recommendations',
              style: TextStyle(
                fontSize: 30,
                fontFamily: FontFamily.montserratBold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                customElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogin(email: 'email', password: 'password'));
                  }, 
                  label: 'Login',
                  textColor: AppColor.primaryColor,
                  backgroundColor: AppColor.secondaryColor,
                ),
                const SizedBox(height: 10),
                customTextButton(
                  label1: 'Don\'t have an account? ', 
                  label2: 'Sign Up',
                  textColor1: Colors.white,
                  textColor2: AppColor.hippieBlue, 
                  onTap: () => context.read<AuthBloc>().add(AuthRegister(name: 'name', email: 'email', password: 'password'))
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}