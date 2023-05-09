import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CompleteRegistration3Screen.dart';

class CompleteRegistration2Screen extends StatefulWidget {
  const CompleteRegistration2Screen({Key? key}) : super(key: key);

  @override
  State<CompleteRegistration2Screen> createState() => _CompleteRegistration2ScreenState();
}

class _CompleteRegistration2ScreenState extends State<CompleteRegistration2Screen> {


  TextEditingController emailTextEditingController = TextEditingController();

  List<String> genderPreferences = [
    "Male",
    "Female",
    "Transgender",
    "Other"
  ];

  List<String> sexualIdentityPreferences = [
    "Male",
    "Female",
    "Transgender",
    "Non-Binary",
    "Other"
  ];

  String? genderPreference;
  String? sexualIdentityPreference;


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*0.1,),
              ReusableWidgets().FluidHeaderText("Please Select Your",context),
              SizedBox(height: size.height*0.05,),
              ReusableWidgets().FluidDropDown(
                  context,
                  "Sexual identity preference","Please Select...",sexualIdentityPreferences,(val){
                sexualIdentityPreference = val;
                setState(() {});
              },sexualIdentityPreference
              ),
              SizedBox(height: size.height*0.05,),
              ReusableWidgets().FluidDropDown(
                  context,
                  "Gender preference","Please Select...",genderPreferences,(val){
                genderPreference = val;
                setState(() {

                });
              },genderPreference
              ),
              SizedBox(height: size.height*0.4,),
              ReusableWidgets().FluidButton("NEXT", (){


                Get.to(CompleteRegistration3Screen());


              }, context),

            ],
          ),
        ),
      ),
    );


  }
}
