import 'dart:io';
import 'dart:ui';
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

  SharedPreferences? prefs;




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
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 10 * _controller.value),
                child: Image.asset(
                    "assets/top_left.png"
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 10 * _controller.value),
                  child: Image.asset(
                      "assets/top_right.png"
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 10 * _controller.value),
                  child: Image.asset(
                      "assets/bottom_right.png"
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 10 * _controller.value),
                  child: Image.asset(
                      "assets/middle_left.png"
                  ),
                );
              },
            ),
          ),
          Container(
            decoration:  BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.withOpacity(0.8), Colors.blue.withOpacity(0.8)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )),
          ),
          Center(
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
        ],
      ),
    );
  }

  Future<void> loadProperScreen() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs?.containsKey("registered")??false){
      if(prefs?.getBool("registered")??false){
        Get.to(HomeScreenTab());
      }
      else{
        Get.to(SignUpOrLoginScreen());
      }
    }
    else{
      Get.to(SignUpOrLoginScreen());
    }
  }
}
