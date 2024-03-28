import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_app/style/constants.dart';

class AppTheme {
  ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
      primary: Color(primaryColor),
      // secondary: Color(primaryColor),
    ),
    brightness: Brightness.dark,
    // primaryColor: Color(primaryColor),
    // buttonTheme: ButtonThemeData(buttonColor: Color(primaryColor)),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.openSans(
          color: const Color(primaryColor), fontWeight: FontWeight.w500),
      titleLarge: GoogleFonts.poppins(color: Colors.white),
      titleSmall: GoogleFonts.openSans(color: Colors.white),
      bodySmall: GoogleFonts.openSans(color: Colors.white),
    ),
    // cardColor: const Color(0xFF232323),
  );
  ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    textTheme: TextTheme(
      displaySmall: GoogleFonts.openSans(color: const Color(primaryColor)),
      titleLarge: GoogleFonts.openSans(color: Colors.black),
      titleSmall: GoogleFonts.openSans(color: Colors.black),
      bodySmall: GoogleFonts.openSans(color: Colors.black),
    ),
  );
}
