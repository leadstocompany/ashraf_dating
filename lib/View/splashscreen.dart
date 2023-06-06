import 'dart:io';
import 'dart:ui';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:fluid_dating_app/View/HomeScreenTab.dart';
import 'package:fluid_dating_app/View/registration_screens/SignUpOrLoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed){
        SchedulerBinding.instance.addPostFrameCallback((_){
         loadProperScreen();
        });
      }
    });
    _controller.forward();

    // <-- Set your duration here.
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body:AnimateGradient(
        primaryBegin: Alignment.topLeft,
        duration: Duration(seconds: 3),
        /*primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,*/
        primaryColors: const [
          Color(0xff873F9F),
          Color(0xffFFADED),
          Color(0xff9A69E1),
          Colors.white,
        ],
        secondaryColors: const [
          Color(0xffFFADED),
          Color(0xff98D2EB),
          Color(0xff9A69E1),
          Colors.blue,
        ],
        child:Container(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height*0.18,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:size.height*0.02,horizontal: size.width*0.15),
                  child: Image.asset(
                      "assets/verve_white.png"
                  ),
                ),
                Text("Connecting hearts\nbeyond the binary",style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 24),
                )),
                SizedBox(height: size.height*0.3,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 48,vertical: 14),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("LET’S GET\nSTARTED",style: GoogleFonts.raleway(
                    textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 13),
                  ),),
                )
              ],
            ),
          ),
          height: size.height,width: size.width,),
      ),
    );
  }

  Future<void> loadProperScreen() async {
    Get.to(SignUpOrLoginScreen());
  }
}
