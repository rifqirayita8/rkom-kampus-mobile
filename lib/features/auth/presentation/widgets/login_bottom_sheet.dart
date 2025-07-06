import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rkom_kampus/gen/assets.gen.dart';
import 'package:rkom_kampus/widgets/custom_elevated_button.dart';
import 'package:rkom_kampus/widgets/custom_text_button.dart';
import 'package:rkom_kampus/widgets/custom_textfield.dart';
import '../../../../utils/colors.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> 
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<Offset> _animation;
  final TextEditingController _nameEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation= Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
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
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Your journey is finally here',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.mediumGray,
              ),
            ),
            Form(
              child: Column(
                children: [
                  customTextField(
                    label: 'Username or Email', 
                    controller: _nameEmailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  customTextField(
                    label: 'Enter your password', 
                    controller: _passwordController,
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      }, 
                      icon: SvgPicture.asset(
                        _obscureText
                          ? Assets.images.common.eye
                          : Assets.images.common.eyeOff,
                      )
                    ),
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
                    onPressed: () {}, 
                    label: 'Login'
                  ),
                  customTextButton(
                    label1: 'Don\'t have an account? ', 
                    label2: 'Sign Up', 
                    onTap: () {}
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}