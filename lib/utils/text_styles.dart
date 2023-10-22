import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle regularText({Color? color, double fontSize = 14}) {
  return GoogleFonts.mulish(color: color, fontSize: fontSize);
}

TextStyle mediumText({Color? color, double fontSize = 16}) {
  return GoogleFonts.mulish(
      color: color, fontWeight: FontWeight.w500, fontSize: fontSize);
}

TextStyle semiBoldText({Color? color, double fontSize = 16}) {
  return GoogleFonts.mulish(
      color: color, fontWeight: FontWeight.w600, fontSize: fontSize);
}

TextStyle boldText({Color? color, double fontSize = 16}) {
  return GoogleFonts.mulish(
      color: color, fontWeight: FontWeight.bold, fontSize: fontSize);
}

TextStyle extraBoldText({Color? color, double fontSize = 16}) {
  return GoogleFonts.mulish(
      color: color, fontWeight: FontWeight.w800, fontSize: fontSize);
}
