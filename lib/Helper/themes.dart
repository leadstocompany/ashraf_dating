import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes{

  ThemeData fluidsLightTheme = ThemeData(
    primaryColor: Color(0xff873F9F),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff873F9F),foregroundColor:Colors.white),
      textTheme: GoogleFonts.ralewayTextTheme().copyWith().apply(displayColor: Colors.black),
  );

  ThemeData fluidBlackOnWhiteTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xff873F9F),
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.ralewayTextTheme().apply(
      bodyColor: Colors.white,displayColor: Colors.white
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.black,foregroundColor: Colors.white),

  );

}