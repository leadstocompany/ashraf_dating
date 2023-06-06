import 'package:fluid_dating_app/helper/themes.dart';
import 'package:fluid_dating_app/shared_preference_keys_strings.dart';
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


class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs?.getString(myStrign) ?? "";

  set username(String value) {
    _sharedPrefs?.setString(myStrign, value);
  }

// ...
}