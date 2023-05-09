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

  bool obscureText1 = false;
  bool obscureText2 = false;
  bool obscureText3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Reset Password"),
          ReusableWidgets().FluidTextField("Current Password", "Current Password", context, currentPasswordTextEditingController, obscureText1, true, () {
            setState(() {
              obscureText1=!obscureText1;
            });
          }, false),
          ReusableWidgets().FluidTextField("New Password", "New Password", context, currentPasswordTextEditingController, obscureText2, true, () {
            setState(() {
              obscureText2=!obscureText2;
            });
          }, false),
          ReusableWidgets().FluidTextField("Confirm New Password", "Confirm New Password", context, currentPasswordTextEditingController, obscureText3, true, () {
            setState(() {
              obscureText3=!obscureText3;
            });
          }, false),
          ReusableWidgets().FluidButton("UPDATE", () {
            //Update NEw Password APis
          }, context),
        ],
      ),
    );
  }
}
