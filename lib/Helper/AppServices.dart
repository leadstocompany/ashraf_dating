import 'package:fluid_dating_app/helper/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AppServices{

  static Future<bool> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }

  static void launchMyUrl(Uri _url) async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  void ChangeTheme(bool enableDarkMode) {

    ThemeData themeData = Themes().fluidsLightTheme;
    if(enableDarkMode){
      themeData = Themes().fluidBlackOnWhiteTheme;
      print("Changing theme to : Dark");
      Get.changeTheme(themeData);

      Get.changeThemeMode(ThemeMode.dark);

    }
    else{
      themeData = Themes().fluidsLightTheme;
      print("Changing theme to :Light");


      Get.changeTheme(themeData);

      Get.changeThemeMode(ThemeMode.light);
    }

  }

}