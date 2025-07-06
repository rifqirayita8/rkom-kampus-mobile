import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';
import '../utils/colors.dart';

Widget customElevatedButton({
  required String label,
  required void Function() onPressed,
  Color? textColor= AppColor.secondaryColor,
  Color? backgroundColor= AppColor.primaryColor,
}) {
  return InkWell(
    onTap: onPressed,
    child: Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontFamily: FontFamily.montserratBold,
                color: textColor,
                fontSize: 20
              ),
            ),
          ],
        ),
      ),
    ),
  );
}