import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/View/registration_screens/MobileAuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SignUpOrLoginScreen extends StatefulWidget {
  const SignUpOrLoginScreen({Key? key}) : super(key: key);

  @override
  State<SignUpOrLoginScreen> createState() => _SignUpOrLoginScreenState();
}

class _SignUpOrLoginScreenState extends State<SignUpOrLoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isSignUpScreenToBeDisplayed = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableWidgets().FluidHeaderText("Create an account",context),
            ReusableWidgets().FluidTextField("Email Id", "Enter your email", context, emailTextEditingController,false,true,null,false),
            ReusableWidgets().FluidTextField("Password", "Enter your password", context, passwordTextEditingController,obscurePassword,true,(){
              obscurePassword = !obscurePassword;
              setState(() {});
            },false),
            ReusableWidgets().FluidButton("Sign Up", (){


              Get.to(MobileAuthScreen());


            }, context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(color: Colors.black,height: 1,width: size.width*0.25,),
                Text("  or continue with  "),
                Container(color: Colors.black,height: 1,width: size.width*0.25,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaceBookBtn(),
                SizedBox(width: 10,),
                GoogleBtn(),
                SizedBox(width: 10,),
                AppleBtn(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account ?"),
                Text("Sign in"),
              ],
            ),
            Column(
              children: [
                Text("By signing up, you agree to Photo’s"),
                SizedBox(width: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Terms of Service",style: TextStyle(decoration: TextDecoration.underline,),),
                    Text(" and "),
                    Text("Privacy Policy.",style: TextStyle(decoration: TextDecoration.underline,),),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  FaceBookBtn() {
    return CircleAvatar(
      radius: 30,
    );
  }
  GoogleBtn() {
    return CircleAvatar(
      radius: 30,
    );
  }
  AppleBtn() {
    return CircleAvatar(
      radius: 30,
    );
  }

}
