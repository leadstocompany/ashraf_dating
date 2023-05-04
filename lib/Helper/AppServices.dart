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

}