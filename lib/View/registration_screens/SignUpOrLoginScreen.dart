import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_dating_app/Helper/AuthMethods.dart';
import 'package:fluid_dating_app/Helper/progress_dialog.dart';
import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/View/WelcomeBackScreen.dart';
import 'package:fluid_dating_app/View/registration_screens/MobileAuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'complete_profile_screens/CompleteRegistration1Screen.dart';

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

  bool _isLoading = false;

  String? passwordErrorText;
  String? emailErrorText;

  bool wantsToSignUp = true;

  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: wantsToSignUp?SignUpWidgets():LoginWidgets(),
      ),
    );
  }

  FaceBookBtn() {
    return InkWell(
      onTap: () async {
        ProgressDialog.show(context, "Signing with\n Facebook");
        UserCredential userCredential = await AuthMethods().signInWithFacebook();
        if(userCredential.user != null){
          // wrong call in wrong place!
          prefs?.setBool("registered",true);
          Get.to(CompleteRegistration1Screen());
        }
        ProgressDialog.hide();
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: !Get.isDarkMode?Colors.black:Colors.white,
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Get.isDarkMode?Colors.black:Colors.white,
          child: CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage("assets/Facebook.png"),
          ),
        ),
      ),
    );
  }

  GoogleBtn() {
    return InkWell(
      onTap: () async {
        ProgressDialog.show(context, "Signing with\n Google");
        UserCredential userCredential = await AuthMethods().signInWithGoogle();
        if(userCredential.user != null){
          // wrong call in wrong place!
          prefs?.setBool("registered",true);
          Get.to(CompleteRegistration1Screen());
        }
        ProgressDialog.hide();
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: !Get.isDarkMode?Colors.black:Colors.white,
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Get.isDarkMode?Colors.black:Colors.white,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/Google.png"),
          ),
        ),
      ),
    );
  }

  AppleBtn() {
    return InkWell(
      onTap: () async {
        ProgressDialog.show(context, "Signing with\n Apple");
        UserCredential userCredential = await AuthMethods().signInWithApple();
        if(userCredential.user != null){
          // wrong call in wrong place!
          prefs?.setBool("registered",true);
          Get.to(CompleteRegistration1Screen());
        }
        ProgressDialog.hide();
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/Apple.png"),
          ),
        ),
      ),
    );
  }

  Future<String> _logInUser() async {
    if (emailTextEditingController.text.isEmpty) {
      emailErrorText = "Email address cannot be blank";
    } else if (passwordTextEditingController.text.isEmpty) {
      passwordErrorText = "Password cannot be blank";
    }
    String result = await AuthMethods().logInUser(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    );
    if (result == 'successs') {
    } else {
      
      Get.snackbar(
          result,
          'Would You Like to Login Instead ?',
          snackPosition: SnackPosition.BOTTOM,
          onTap: (GetSnackBar){
              print(wantsToSignUp=!wantsToSignUp);
          }
      );
    }
    setState(() {});
    return result;
  }

  Future<String> _signUp() async {
    String result = await AuthMethods().signUpUser(email: emailTextEditingController.text, password: passwordTextEditingController.text);
    setState(() {});
    return result;
  }

  SignUpWidgets() {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height*0.1,),
        ReusableWidgets().FluidHeaderText("Create an account",context),
        ReusableWidgets().FluidTextField("Email Id", "Enter your email", context, emailTextEditingController,false,true,null,false),
        ReusableWidgets().FluidTextField("Password", "Enter your password", context, passwordTextEditingController,obscurePassword,true,(){
          obscurePassword = !obscurePassword;
          setState(() {});
        },false),
        ReusableWidgets().FluidButton("Sign Up", () async {

          Get.to(MobileAuthScreen());





          /*if(emailTextEditingController.text.isNotEmpty){
            emailErrorText = null;
            if(passwordTextEditingController.text.isNotEmpty){
              emailErrorText = null;
              passwordErrorText =null;
              ProgressDialog.show(context, "Signing You\nUp");
              String result = await _signUp();
              ProgressDialog.hide();
              if(result=='success'){
                prefs?.setBool("registered",true);
                Get.to(CompleteRegistration1Screen());
              }
              if (result != 'success') {
                Get.snackbar(
                    result,"",
                    snackPosition: SnackPosition.BOTTOM
                );
              }
            }
            else{
              passwordErrorText = "Password cannot be blank";
            }
          }
          else{
            emailErrorText = "Email cannot be blank";
          }*/
        }, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(color:Get.isDarkMode?Colors.white: Colors.black,height: 1,width: size.width*0.25,),
            Text("  or continue with  "),
            Container(color: Get.isDarkMode?Colors.white: Colors.black,height: 1,width: size.width*0.25,),
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
            InkWell(
                onTap: (){
                  wantsToSignUp=!wantsToSignUp;
                  setState(() {

                  });
                },
                child: Text(" Log in",style: TextStyle(color: Theme.of(context).primaryColor),)),
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
    );
  }

  LoginWidgets() {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height*0.1,),
        ReusableWidgets().FluidHeaderText("Create an account",context),
        ReusableWidgets().FluidTextField("Email Id", "Enter your email", context, emailTextEditingController,false,true,null,false),
        ReusableWidgets().FluidTextField("Password", "Enter your password", context, passwordTextEditingController,obscurePassword,true,(){
          obscurePassword = !obscurePassword;
          setState(() {});
        },false),
        ReusableWidgets().FluidButton("Log In", () async {

          Get.to(MobileAuthScreen());
          return;

          if(emailTextEditingController.text.isNotEmpty){
            emailErrorText = null;
            if(passwordTextEditingController.text.isNotEmpty){
              emailErrorText = null;
              passwordErrorText =null;
              ProgressDialog.show(context, "Logging You\nIn");
              String result = await _logInUser();
              ProgressDialog.hide();
              if(result=='success'){
                prefs?.setBool("registered",true);
                Get.to(CompleteRegistration1Screen());
              }
              if (result != 'success') {
                Get.snackbar(
                    result,
                    '',
                    snackPosition: SnackPosition.BOTTOM
                );
              }
            }
            else{
              passwordErrorText = "Password cannot be blank";
            }
          }
          else{
            emailErrorText = "Email cannot be blank";
          }

        }, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(color:Get.isDarkMode?Colors.white: Colors.black,height: 1,width: size.width*0.25,),
            Text("  or continue with  "),
            Container(color: Get.isDarkMode?Colors.white: Colors.black,height: 1,width: size.width*0.25,),
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
            Text("Don't have an account ?"),
            InkWell(
                onTap: (){

                  wantsToSignUp=!wantsToSignUp;
                  setState(() {

                  });
                },
                child: Text(" Sign Up",style: TextStyle(color: Theme.of(context).primaryColor),)),
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
                InkWell(
                    onTap: (){
                      Get.to(CompleteRegistration1Screen());
                    },
                    child: Text("Privacy Policy.",style: TextStyle(decoration: TextDecoration.underline,),)),
              ],
            )
          ],
        ),
      ],
    );
  }

  Future<void> getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

}
