import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';
import '../utils/colors.dart';

Widget customTextButton({
  required String label1,
  required String label2,
  required void Function() onTap,
  Color textColor1 = AppColor.mediumGray,
  Color textColor2 = AppColor.primaryColor,
  bool isSpread= true,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
}) {
  return Row(
    mainAxisAlignment: mainAxisAlignment,
    children: [
      if (isSpread)
      Text(
        label1,
        style: TextStyle(
          fontSize: 16,
          fontFamily: FontFamily.montserratRegular,
          color: textColor1,
        ),
      ),
      InkWell(
        onTap: onTap,
        child: Text(
          label2,
          style: TextStyle(
            fontSize: 16,
            fontFamily: FontFamily.montserratBold,
            color: textColor2,
          ),
        ),
      ),
    ],
  );
}