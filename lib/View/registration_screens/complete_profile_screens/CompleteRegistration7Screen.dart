import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteRegistration7Screen extends StatefulWidget {
  const CompleteRegistration7Screen({Key? key}) : super(key: key);

  @override
  State<CompleteRegistration7Screen> createState() => _CompleteRegistration7ScreenState();
}

class _CompleteRegistration7ScreenState extends State<CompleteRegistration7Screen> {


  TextEditingController emailTextEditingController = TextEditingController();


  bool isVerified = false;


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: isVerified?VerificationCompleteUI():VerficationFailedUI(),
    );
  }

  Widget VerficationFailedUI() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReusableWidgets().FluidBoldHeaderText("We’re sorry to say, but you have not passed our profile verification process.",context,true),
          Container(
            height: size.height*0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/reverify_graphics.png")
                )
            ),
          ),

          SizedBox(height: size.height*0.07,),
          ReusableWidgets().FluidButton("RE-VERIFY", (){
            print(isVerified);
            print("aslaksal;");
            setState(() {
              isVerified =! isVerified;
            });
            print("aslaksal;");
            print(isVerified);
          }, context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
            child: Text("etc etc follow community guidelines on ..."
                "matches can report each other for inappropriate behaviour, "
                "any such complain will be investigated and may result in banning"
                " your account etc etc ",textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }

  Widget VerificationCompleteUI() {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReusableWidgets().FluidBoldHeaderText("Success!",context,true),
          Text("We are stoked to have you join our community!"),
          Container(

            height: size.height*0.4,
            child: Center(child: Text("Graphics To be Added Here")),
          ),
          ReusableWidgets().FluidBoldHeaderText("You're Verified",context,true),
          ReusableWidgets().FluidParagraphText("Let's get you in!",context),
          SizedBox(height: size.height*0.07,),
          ReusableWidgets().FluidButton("NEXT", (){


            Get.to(CompleteRegistration7Screen());


          }, context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
            child: Text("etc etc follow community guidelines on ..."
                "matches can report each other for inappropriate behaviour, "
                "any such complain will be investigated and may result in banning"
                " your account etc etc ",textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}
