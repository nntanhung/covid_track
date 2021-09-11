import 'package:flutter/material.dart';

class AppColors {
  static final Color backgroundColor = Color(0xFF3383CD);
  static final Color mainColor = Color(0xFF11249F);
}

const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecoverColor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
const kSplashColor = Color(0xE6EFF6);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(0.3);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

MaterialColor swatchify(MaterialColor color, int value) {
  return MaterialColor(color[value].hashCode, <int, Color>{
    50: color[value],
    100: color[value],
    200: color[value],
    300: color[value],
    400: color[value],
    500: color[value],
    600: color[value],
    700: color[value],
    800: color[value],
    900: color[value],
  });
}

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(fontSize: 15, color: kBodyTextColor);

const kTitleTextStyle = TextStyle(
  fontSize: 17,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);

const kDescribeStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w300);

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]}.';

const int ONE_THOUSAND = 1000;

/// Zeros least significant digits
int simplifyNumber(int val) {
  int multiplier = 1;
  while (val > ONE_THOUSAND) {
    val = (val ~/ ONE_THOUSAND).floor();
    multiplier *= ONE_THOUSAND;
  }
  return val * multiplier;
}
