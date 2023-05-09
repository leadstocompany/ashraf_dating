import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_codes/country_codes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'Themes.dart';

class AppHelper {

  static bool leapYear(DateTime date) {
    if(date.year%4 == 0) {
      if(date.year%100 == 0){
        return date.year%400 == 0;
      }
      return true;
    }
    return false;
  }


  static List<int> differenceInYearsMonthsDays(DateTime dt1, DateTime dt2) {
    List<int> simpleYear = [31,28,31,30,31,30,31,31,30,31,30,31];
    if(dt1.isAfter(dt2)) {
      DateTime temp = dt1;
      dt1 = dt2;
      dt2 = temp;
    }
    int totalMonthsDifference = ((dt2.year*12) + (dt2.month - 1)) - ((dt1.year*12) + (dt1.month - 1));
    int years = (totalMonthsDifference/12).floor();
    int months = totalMonthsDifference%12;
    late int days;
    if(dt2.day >= dt1.day) {days = dt2.day - dt1.day;}
    else {
      int monthDays = dt2.month == 3
          ? (leapYear(dt2)? 29: 28)
          : (dt2.month - 2 == -1? simpleYear[11]: simpleYear[dt2.month - 2]);
      int day = dt1.day;
      if(day > monthDays) day = monthDays;
      days = monthDays - (day - dt2.day);
      months--;
    }
    if(months < 0) {
      months = 11;
      years--;
    }
    return [years, months, days];
  }

  static List<int> differenceInMonths(DateTime dt1, DateTime dt2){
    List<int> inYears = differenceInYearsMonthsDays(dt1, dt2);
    int difMonths = (inYears[0]*12) + inYears[1];
    return [difMonths, inYears[2]];
  }

  static Future<File> compressImage(File originalImageFile,int compressionAmount) async{
    var rng = Random();
    String randomName = "test"+rng.nextInt(100).toString()+rng.nextInt(100).toString();
    final dir = await path_provider.getTemporaryDirectory();
    File compressedFile = AppHelper.createFile("${dir.absolute.path}/$randomName.jpg");
    compressedFile = (await FlutterImageCompress.compressAndGetFile(
      originalImageFile.absolute.path, compressedFile.path,
      quality: 88,
    ))!;
    return compressedFile;
  }

  static Future<File> fixHorizontalFlip(XFile originalImageFile, bool isFrontCam) async{
    if(!isFrontCam){
      return File(originalImageFile.path);
    }
    List<int> imageBytes = await originalImageFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(imageBytes);
    img.Image fixedImage = img.flipHorizontal(originalImage!);
    File file = File(originalImageFile.path);
    File fixedFile = await file.writeAsBytes(
      img.encodeJpg(fixedImage),
      flush: true,
    );
    return fixedFile;
  }

  static File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
  }



  Future<File> fileFromImageUrl(String imageUrl) async {
    print("Kya bolte Company");
    print(imageUrl);
    final response = await http.get(Uri.parse(imageUrl));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'imagetdsest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  Widget LaodingPleaseWaitWidget(String? textToShow,BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(textToShow??"Please Wait",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor==Colors.white?Colors.black:Theme.of(context).primaryColor),textAlign: TextAlign.center,
        ),
        SizedBox(width: 20,),
        Container(
          child: getCircularProgressIndicator(context),
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(8.0),
        )
      ],
    );
  }

  getCircularProgressIndicator(BuildContext context,{double? height, double? width}) {
    height ??= 40.0;
    width ??= 40.0;
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child:  CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor==Colors.white?Colors.black:Theme.of(context).primaryColor),
        ),
        height: height,
        width: width,
      ),
    );
  }

  Future<PhoneNumber> getCountryCode() async {
    await CountryCodes.init(); // Optionally, you may provide a `Locale` to get countrie's localizadName

    final Locale? deviceLocale = CountryCodes.getDeviceLocale();
    print(deviceLocale?.languageCode); // Displays en
    print(deviceLocale?.countryCode); // Displays US

    final CountryDetails details = CountryCodes.detailsForLocale();
    print(details.alpha2Code); // Displays alpha2Code, for example US.
    print(details.dialCode);
    PhoneNumber number = PhoneNumber(isoCode: details.alpha2Code, dialCode: details.dialCode);
    // Displays the dial code, for example +1.
    print(
        details.name); // Displays the extended name, for example United States.
    print(details.localizedName);
    print("Setting Number to :");
    print(details.dialCode);
    print(number?.isoCode);
    return number;
  }


}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


