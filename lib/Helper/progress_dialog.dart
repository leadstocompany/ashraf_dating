import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../globals.dart';

class ProgressDialog {

  static OverlayEntry? currentLoader;
  static bool isShowing = false;

  static void show(BuildContext context, String? textToShow) {
    if (!isShowing) {
      currentLoader = OverlayEntry(
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            child: Container(
              color: Colors.black87,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(textToShow??"Please Wait",style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline5,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 20,),
                    Container(
                      child: getCircularProgressIndicator(context),
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),

                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              // do nothing
            },
            onDoubleTap: () {
              ProgressDialog.hide();
            },
          ),
        ),
      );
      Overlay.of(context)?.insert(currentLoader!);
      isShowing = true;
    }
  }

  static void hide() {
    if (currentLoader != null) {
      currentLoader?.remove();
      isShowing = false;
      currentLoader = null;
    }
  }

  static getCircularProgressIndicator(BuildContext context,{double? height, double? width}) {
    height ??= 40.0;
    width ??= 40.0;
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child:  CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
        height: height,
        width: width,
      ),
    );
  }

  static getErrorWidget() {
    return Container(
      alignment: Alignment.center,
      child: const SizedBox(
        child: Text("Oops! Something went wrong."),
      ),
    );
  }
}


class ProgressDialogSpecial {

  static OverlayEntry? currentLoader;
  static bool isShowing = false;

  static void show(BuildContext context, String? textToShow) {
    if (!isShowing) {
      currentLoader = OverlayEntry(
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            child: Container(
              color: Colors.black87,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: getCircularProgressIndicator(context),
                      width: 200,
                      height: 200,
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Text(textToShow??"Please Wait",style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline5,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              // do nothing
            },
            onDoubleTap: () {
              ProgressDialogSpecial.hide();
            },
          ),
        ),
      );
      Overlay.of(context)?.insert(currentLoader!);
      isShowing = true;
    }
  }

  static void hide() {
    if (currentLoader != null) {
      currentLoader?.remove();
      isShowing = false;
      currentLoader = null;
    }
  }

  static getCircularProgressIndicator(BuildContext context,{double? height, double? width}) {
    height ??= 300.0;
    width ??= 300.0;
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child:  Stack(
          children: [
            Center(
              child: FaIcon(
                FontAwesomeIcons.microchip,
                color: Theme.of(context).primaryColor,size: 60,
              ),
            ),
            SizedBox(
              width: 400,height: 400,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
        height: height,
        width: width,
      ),
    );
  }

  static getErrorWidget() {
    return Container(
      alignment: Alignment.center,
      child: const SizedBox(
        child: Text("Oops! Something went wrong."),
      ),
    );
  }
}
