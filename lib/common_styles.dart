import 'package:flutter/material.dart';

Color colorByMode(BuildContext context, Color lightColor, Color darkColor) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return darkColor;
  } else {
    return lightColor;
  }
}

class CommonStyles {

  static TextStyle normalTextBlack(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        color: colorByMode(context, Colors.black87, Colors.white));
  }

  static TextStyle boldTextBlack(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w700,
        color: colorByMode(context, Colors.black87, Colors.white));
  }

  static TextStyle size16Black700(BuildContext context) {
    return TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: colorByMode(context, Colors.black87, Colors.white));
  }
}