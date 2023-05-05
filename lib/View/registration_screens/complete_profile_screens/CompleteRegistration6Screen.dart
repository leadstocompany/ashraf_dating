import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CompleteRegistration7Screen.dart';

class CompleteRegistration6Screen extends StatefulWidget {
  const CompleteRegistration6Screen({Key? key}) : super(key: key);

  @override
  State<CompleteRegistration6Screen> createState() => _CompleteRegistration6ScreenState();
}

class _CompleteRegistration6ScreenState extends State<CompleteRegistration6Screen> {


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image:DecorationImage(image: AssetImage("bg_blob.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("We are verifying\nyour account",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),textAlign: TextAlign.center,),
                Text("We take our app security very seriously, so you can enjoy... in a safe environment ",style: TextStyle(fontWeight: FontWeight.w400,),textAlign: TextAlign.center),
                SizedBox(height: size.height*0.4,),
                Text("Thank your for\nyour patience!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30,),textAlign: TextAlign.center),
                Text("We will notify you via email when your account has been\nverified, please note the process can take up to 24h. ",style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );


  }
}
