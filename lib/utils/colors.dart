import 'package:flutter/material.dart';

const kPrimaryBlue = Color(0xFF327BE5);
const kPrimaryDark = Color(0xFF0F1215);
const kPink = Color(0xFFF780AB);
const Color kTextFieldStroke = Color(0xffE4E7EC);
const kTextColor = Color(0xFF565758);
const kWhite = Colors.white;

MaterialColor materialPrimaryColor() {
  Color color = kPrimaryBlue;
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red,
      g = color.green,
      b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
