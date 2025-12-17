import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {

  static const Color purpleButton = Color(0xff4527a0);

  static TextStyle titleLarge(BuildContext context) {
    return GoogleFonts.aBeeZee(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle buttonDark(BuildContext context) {
    return GoogleFonts.comfortaa(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle buttonLight(BuildContext context) {
    return GoogleFonts.comfortaa(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }
}