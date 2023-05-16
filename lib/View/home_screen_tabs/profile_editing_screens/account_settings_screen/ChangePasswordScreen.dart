import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  TextEditingController currentPasswordTextEditingController = TextEditingController();
  TextEditingController newPasswordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.05,),
            ReusableWidgets().FluidHeaderText("Reset Password",context),
            SizedBox(height: size.height*0.1,),
            ReusableWidgets().FluidTextField("Current Password", "Current Password", context, currentPasswordTextEditingController, obscureText1, true, () {
              setState(() {
                obscureText1=!obscureText1;
              });
            }, false),
            SizedBox(height: size.height*0.025,),
            ReusableWidgets().FluidTextField("New Password", "New Password", context, currentPasswordTextEditingController, obscureText2, true, () {
              setState(() {
                obscureText2=!obscureText2;
              });
            }, false),
            SizedBox(height: size.height*0.025,),
            ReusableWidgets().FluidTextField("Confirm New Password", "Confirm New Password", context, currentPasswordTextEditingController, obscureText3, true, () {
              setState(() {
                obscureText3=!obscureText3;
              });
            }, false),
            SizedBox(height: size.height*0.1,),
            ReusableWidgets().FluidButton("UPDATE", () {
              //Update NEw Password APis
            }, context),
          ],
        ),
      ),
    );
  }
}
