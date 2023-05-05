import 'dart:io';
import 'dart:ui';
import 'package:fluid_dating_app/View/HomeScreenTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/route_manager.dart';

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
      duration: Duration(seconds: 2),
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed)
        sleep(Duration(seconds:2));
        SchedulerBinding.instance.addPostFrameCallback((_){
          Get.to(HomeScreenTab());
        });
    });
    _controller.forward();

    // <-- Set your duration here.
  }

  @override
  Widget build(BuildContext context) {
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
                    "top_left.png"
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
                      "top_right.png"
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
                      "bottom_right.png"
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
                      "middle_left.png"
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
            child: Image.asset(
                "fluid_splashscreen_logo.png"
            ),
          ),
        ],
      ),
    );
  }
}
