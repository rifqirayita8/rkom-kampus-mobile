import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rkom_kampus/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rkom_kampus/gen/fonts.gen.dart';
import 'package:rkom_kampus/utils/colors.dart';

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
                InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogin(email: 'a', password: 'a'));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text('Login',
                            style: TextStyle(
                              fontFamily: FontFamily.montserratBold,
                              color: AppColor.primaryColor,
                              fontSize: 20
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.montserratRegular,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<AuthBloc>().add(AuthRegister(name: 'a', email: 'a', password: 'a'));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.montserratBold,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dashed,
                          color: AppColor.hippieBlue,
                        ),
                      ),
                    ),
                  ],
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