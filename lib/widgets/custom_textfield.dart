import 'package:flutter/material.dart';
import '../utils/colors.dart';

Widget customTextField({
  required String label,
  TextEditingController? controller,
  Widget? suffixIcon,
  TextInputType? keyboardType,
  bool? obscureText = false,
  void Function(String)? onChanged,
  String? initialValue,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText ?? false,
    keyboardType: keyboardType,
    onChanged: onChanged,
    initialValue: initialValue,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: AppColor.hippieBlue.withOpacity(0.5),
      labelText: label,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}