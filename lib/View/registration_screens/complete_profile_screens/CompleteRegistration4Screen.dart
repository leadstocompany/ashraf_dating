import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration5Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteRegistration4Screen extends StatefulWidget {
  const CompleteRegistration4Screen({Key? key}) : super(key: key);

  @override
  State<CompleteRegistration4Screen> createState() => _CompleteRegistration4ScreenState();
}

class _CompleteRegistration4ScreenState extends State<CompleteRegistration4Screen> {


  TextEditingController emailTextEditingController = TextEditingController();

  var professionList = <String>['Actress', 'Singer', 'Director', 'Producer'];
  String? profession = 'Actress';


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,automaticallyImplyLeading: true,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableWidgets().FluidHeaderText("Verify your Account",context),
            RichText(
              text: TextSpan(
                  text: 'Verification is',
                  style:  TextStyle(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(text: ' necessary ',
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'to use the app, for creating a safe environment our users.',
                      style: TextStyle(color: Colors.grey),
                    )
                  ]
              ),
            ),
            Text("Verify your identity using your government issued ID for the highest security.",style: TextStyle(color: Colors.grey),),
            Text("We don’t store your ID information. ",style: TextStyle(color: Colors.grey),),
            ReusableWidgets().FluidButtonColor("ID VERIFICATION", (){
              Get.to(CompleteRegistration5Screen(profileName: 'asasas',));
            },Color(0xff47429D), context,Icon(Icons.document_scanner_outlined,color: Colors.white,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(color: Colors.black,height: 1,width: size.width*0.25,),
                Text("  or continue with  "),
                Container(color: Colors.black,height: 1,width: size.width*0.25,),
              ],
            ),
            Text("Verify your account by taking a one-time "
                "selfie that won’t be visible on your profile. ",style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),

            ReusableWidgets().FluidButtonColor("SELFIE VERIFICATION", (){


              Get.to(CompleteRegistration5Screen(profileName: 'asasas',));


            },Color(0xff8681E9), context,null),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Photo won’t be associated with your account and will only be used to secure your account and keep you safe.",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),
                  Text("Contact Tech support",style: TextStyle(color: Color(0xff725AC1),decoration: TextDecoration.underline),),
                ],
              ),
            )
          ],
        ),
      ),
    );


  }
}
