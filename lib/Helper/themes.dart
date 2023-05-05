import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes{

  ThemeData fluidsLightTheme = ThemeData(
    primaryColor: Color(0xff873F9F),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff873F9F),foregroundColor:Colors.white),
      textTheme: GoogleFonts.ralewayTextTheme().copyWith().apply(displayColor: Colors.black),
  );

  ThemeData fluidBlueTheme = ThemeData(
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white,foregroundColor: Colors.blueAccent),
    textTheme: GoogleFonts.ralewayTextTheme().copyWith(),
  );

  ThemeData fluidWhiteOnBlackTheme = ThemeData(
    primaryColor: Colors.white,
    bottomAppBarColor: Colors.black,
    cardColor: Colors.black,
    splashColor: Colors.white,
    drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
    appBarTheme: AppBarTheme(backgroundColor: Colors.black,foregroundColor: Colors.white),
    scaffoldBackgroundColor: Colors.black,
      canvasColor: Colors.black,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white), //<-- SEE HERE
      ),
    textTheme: GoogleFonts.ralewayTextTheme().apply(
        bodyColor: Colors.white,displayColor: Colors.white,
    )
  );

  ThemeData fluidBlackOnWhiteTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.ralewayTextTheme().apply(
      bodyColor: Colors.white,displayColor: Colors.white
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.black,foregroundColor: Colors.white),

  );

}