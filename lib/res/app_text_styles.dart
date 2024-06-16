import 'package:auto_motive/res/app_color.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle black24BoldTextStyle =
      TextStyle(color: blackColor, fontWeight: FontWeight.bold, fontSize: 24);
  static const TextStyle white24BoldTextStyle =
      TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 24);
  static const TextStyle white24TextStyle =
      TextStyle(color: whiteColor, fontSize: 24);
  static const TextStyle white16BoldTextStyle =
      TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 16);
  static const TextStyle white16TextStyle =
      TextStyle(color: whiteColor, fontSize: 16);
  static const TextStyle white12BoldTextStyle =
      TextStyle(color: whiteColor, fontSize: 12);
  static const TextStyle grey12UnderLineTextStyle = TextStyle(
    fontSize: 12,
    color: grey,
    decoration: TextDecoration.underline,
    decorationColor: grey,
  );
}
