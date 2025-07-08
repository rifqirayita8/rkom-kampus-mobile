import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';
import '../utils/colors.dart';

List<Widget> authBottomSheetHeader({
  required String title1,
  required String title2,
}){
  return [
    Text(
      title1,
      style: TextStyle(
        fontSize: 24,
        fontFamily: FontFamily.montserratBold,
        color: AppColor.primaryColor,
      ),
      textAlign: TextAlign.center,
    ),
    
    Text(
      title2,
      style: TextStyle(
        fontSize: 16,
        fontFamily: FontFamily.montserratMedium,
        color: AppColor.mediumGray,
      ),
    )
  ];
}