import 'dart:async';

import 'package:country_codes/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_dating_app/Helper/AppServices.dart';
import 'package:fluid_dating_app/Network/api_repository.dart';
import 'package:fluid_dating_app/View/WelcomeBackScreen.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration1Screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../Helper/progress_dialog.dart';
import '../../globals.dart';
import '../../main.dart';

class MobileAuthScreen extends StatefulWidget {
  @override
  _MobileAuthScreenState createState() => _MobileAuthScreenState();
}

class _MobileAuthScreenState extends State<MobileAuthScreen> {
  PhoneNumber? number;
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController phoneNumberTextEditingController =
  TextEditingController();
  TextEditingController emailAddressTextEditingController =
  TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verifyID = "";

  String? phoneNumberErrorText;

  bool isCodeNotSend = false;

  bool disableResendOTPBtn = true;

  int howManyTimesResendOTPPressed = 0;
  final int _resendOTPIntervalTime = 60;
  int currentSeconds = 0;

  final interval = const Duration(seconds: 1);

  TextEditingController otpTextEditingController = TextEditingController();

  String headingText = "I've Send you an OTP";

  StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();

  bool hasError = false;

  bool isVerifiedSuccessfully = false;

  String get resendOTPButtonText =>
      '${((_resendOTPIntervalTime - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((_resendOTPIntervalTime - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void startTimer() {
    var duration = interval;
    if (mounted) {
      Timer.periodic(duration, (timer) {
        setState(() {
          print(timer.tick);
          currentSeconds = timer.tick;
          if (timer.tick >= _resendOTPIntervalTime) {
            disableResendOTPBtn = false;
            timer.cancel();
          }
        });
      });
    }
  }

  //TextEditingController otpVerificationTextEditingController = TextEditingController();

  //OTPTextEditController _otpTextEditingController;

  late SharedPreferences prefs;

  // using the initState() method below
  @override
  void initState() {
    super.initState();
    getCountryCode();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    startTimer();
  }

  Future<void> getCountryCode() async {
    await CountryCodes
        .init(); // Optionally, you may provide a `Locale` to get countrie's localizadName

    final Locale? deviceLocale = CountryCodes.getDeviceLocale();
    print(deviceLocale?.languageCode); // Displays en
    print(deviceLocale?.countryCode); // Displays US

    final CountryDetails details = CountryCodes.detailsForLocale();
    print(details.alpha2Code); // Displays alpha2Code, for example US.
    print(details.dialCode);
    number =
        PhoneNumber(isoCode: details.alpha2Code, dialCode: details.dialCode);
    // Displays the dial code, for example +1.
    print(
        details.name); // Displays the extended name, for example United States.
    print(details.localizedName);
    print("Setting Number to :");
    print(details.dialCode);
    print(number?.isoCode);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("Setting Phone Number to");
    print(number!.isoCode);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: !isCodeNotSend
            ? Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.1, right: size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.03),
              Center(child: Image.asset('assets/wings.png', scale: 2)),
              Text(
                "My mobile",
                style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                  "Please enter your valid phone number.\nWe will send you a 6-digit code to verify\nyour account. ",
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45)),
              SizedBox(
                height: size.height * 0.02,
              ),
              MobileTextField(number),
              SizedBox(
                height: size.height * 0.05,
              ),
              InkWell(
                onTap: () {
                  print(number!.dialCode! + phoneNumberTextEditingController.text);

                  ////If User Exists Fill the information

                  phoneSignIn(number!.dialCode! + phoneNumberTextEditingController.text);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: size.height * 0.09,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: GoogleFonts.poppins(
                          textStyle:
                          Theme.of(context).textTheme.titleMedium,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                child: TextButton(
                  onPressed: () {
                    /*AppServices.launchMyUrl(termsURL);*/
                  },
                  child: Text("I've Lost My Phone Number",
                      style: GoogleFonts.poppins(
                          textStyle:
                          Theme.of(context).textTheme.bodyLarge,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor)),
                ),alignment: Alignment.center,
              ),
              SizedBox(
                height: size.height * 0.11,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Divider(thickness: 2,),flex: 3,),
                  Expanded(child: Text("   or sign up",style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.bodySmall,fontWeight: FontWeight.normal,color: Colors.black)),flex: 2,),
                  Expanded(child: Divider(thickness: 2,),flex: 3,),
                ],
              ),
              Text("with",style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.bodySmall,fontWeight: FontWeight.normal,color: Colors.black)),
              SizedBox(height: size.height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: IconButton(icon: FaIcon(FontAwesomeIcons.facebookSquare,size: size.height*0.045,color: Theme.of(context).primaryColor,),onPressed: (){
                    _login();
                  },),flex: 3,),
                  Expanded(child: IconButton(icon:  FaIcon(FontAwesomeIcons.google,size: size.height*0.045,color: Theme.of(context).primaryColor,),onPressed: () async {
                    print("Hola");
                    Authentication.signInWithGoogle(context: context);
                    //await _handleSignIn();
                  },),flex: 3,),
                  Expanded(child:  IconButton(icon:  FaIcon(FontAwesomeIcons.apple,size: size.height*0.045,color: Theme.of(context).primaryColor,),onPressed: (){},),flex: 3,),
                ],
              ),
              SizedBox(height: size.height*0.1,),
              */
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        AppServices.launchMyUrl(termsURL);
                      },
                      child: Text("Terms of use",
                          style: GoogleFonts.poppins(
                              textStyle:
                              Theme.of(context).textTheme.bodyLarge,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).primaryColor)),
                    ),
                    TextButton(
                      onPressed: () {
                        AppServices.launchMyUrl(privacyURL);
                      },
                      child: Text("Privacy Policy",
                          style: GoogleFonts.poppins(
                              textStyle:
                              Theme.of(context).textTheme.bodyLarge,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).primaryColor)),
                    )
                  ],
                ),
              )
            ],
          ),
        )
            : SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/wings.png', scale: 2.5),
                  Text(
                    "$resendOTPButtonText",
                    style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "Type the verification code\n we’ve sent you",
                    style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  //WidgetHelper().TitleTextAnimatedCustom("I've Sent an OTP to \n +91 "+widget.userPhoneNumber,context,true),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // the code below is used to create a textfield for  getting
                              // the OTP from the user
                              PinCodeTextField(
                                appContext: context,
                                textStyle: GoogleFonts.poppins(
                                    textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                    fontWeight: FontWeight.bold,
                                    color: !hasError
                                        ? Colors.white
                                        : Colors.black),
                                controller: otpTextEditingController,
                                keyboardType: TextInputType.number,
                                length: 6,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(200),
                                  activeFillColor: !hasError
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                  inactiveFillColor: Colors.white,
                                  borderWidth: 0.5,
                                  fieldHeight: 60.0,
                                  fieldWidth: 50.0,
                                  activeColor: Theme.of(context).primaryColor,
                                  selectedFillColor: Theme.of(context).primaryColor,
                                  inactiveColor: Color(0xFF24224D),
                                  errorBorderColor: Colors.red,
                                  selectedColor: Color(0xFF24224D),
                                ),
                                cursorColor: Colors.white,
                                enableActiveFill: true,
                                errorAnimationController: errorController,
                                //textStyle: TextStyle(fontSize: 20, height: 1.6),
                                //backgroundColor: Colors.blue.shade50,

                                onChanged: (String value) {
                                  String otp = value;
                                  if (otp == null) {
                                    //AppHelper.showSnackBarMessage("Please enter OTP.");
                                  } else if (otp.length != 6) {
                                    // AppHelper.showSnackBarMessage("Please enter valid OTP.");
                                  } else {
                                    if (!isVerifiedSuccessfully) {
                                      VerifyFirebaseOtp(otp.toString());
                                    }
                                  }
                                  // the below line of code is for debugging purpose
                                  print(
                                      "The OTP entered by the user is: $value");
                                  print(
                                      "The Internal OTP from not Firebase : $otp");
                                },
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              // the code below is used to create a button to be used when the OTP
                              // is not recieved to the user
                              /*Center(
                        child: GestureDetector(
                          onTap: disableResendOTPBtn?null:() {
                            disableResendOTPBtn = true;
                            startTimer();
                            resendCodeAPI(widget.userPhoneNumber.toString());
                          },
                          child: Text(
                              disableResendOTPBtn?'Wait for $resendOTPButtonText':'Code Not Received?',
                              // styling the above text
                              style: TextStyle(color: Colors.black)
                          ),
                        ),
                      ),*/
                              const SizedBox(
                                height: 30.0,
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                      MediaQuery.of(context).size.height *
                                          0.02),
                                  child: Text(
                                    disableResendOTPBtn
                                        ? 'Check Your SMS Inbox ' +
                                        phoneNumberTextEditingController
                                            .text
                                        : 'Send Again',
                                    style: disableResendOTPBtn
                                        ? GoogleFonts.poppins(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45)
                                        : GoogleFonts.poppins(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                onTap: disableResendOTPBtn
                                    ? null
                                    : () {
                                  disableResendOTPBtn = true;
                                  startTimer();
                                  print("Resending OTP");
                                  print(number!.dialCode! +
                                      phoneNumberTextEditingController
                                          .text);
                                  phoneSignIn(number!.dialCode! +
                                      phoneNumberTextEditingController
                                          .text);

                                  setState(() {});
                                },
                              ),

                              Spacer(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        AppServices.launchMyUrl(termsURL);
                                      },
                                      child: Text("Terms of use",
                                          style: GoogleFonts.poppins(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                              fontWeight: FontWeight.normal,
                                              color: Theme.of(context).primaryColor)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        AppServices.launchMyUrl(privacyURL);
                                      },
                                      child: Text("Privacy Policy",
                                          style: GoogleFonts.poppins(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                              fontWeight: FontWeight.normal,
                                              color: Theme.of(context).primaryColor)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))),
                ],
              ),
            )));
  }

  MobileTextField(PhoneNumber? numberd) {
    var size = MediaQuery.of(context).size;
    print("{");
    print(numberd?.dialCode ?? "sa");
    print(number?.dialCode ?? "sasasa");
    return Container(
      padding: EdgeInsets.all(size.height * 0.014),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: kIsWeb ? size.width * 0.2 : size.width * 0.9,
            child: InternationalPhoneNumberInput(
              inputDecoration: InputDecoration(
                border: InputBorder.none,
                errorText: phoneNumberErrorText == null
                    ? null
                    : "Field Cannot Be Blank",
              ),
              textStyle: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              onInputChanged: (PhoneNumber phoneNumber) {
                print(phoneNumber.phoneNumber);
                number = phoneNumber;
              },
              onInputValidated: (bool value) {
                print(value);
              },
              errorMessage: phoneNumberErrorText,
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                showFlags: true,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              initialValue: PhoneNumber(
                  isoCode: numberd?.isoCode, dialCode: numberd?.dialCode),
              textFieldController: phoneNumberTextEditingController,
              formatInput: false,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> phoneSignIn(String phoneNumber) async {
    ProgressDialog.show(context, "Please Wait");

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    isVerifiedSuccessfully = true;
    //disableResendOTPBtn = true;
    startTimer();
    print("verification completed ${authCredential.smsCode}");
    print('STILL IN MOBILE NUMBER SCREEN');
    ProgressDialog.hide();
    await Future.delayed(const Duration(seconds: 2), () {});
    ProgressDialog.hide();
    otpTextEditingController.text = authCredential.smsCode.toString();
    //await Future.delayed(const Duration(seconds: 1), (){});

    try {
      if (user != null) {
        UserCredential credential = await user!.linkWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'provider-already-linked') {

        bool haveRegistered = await ApiRepository().checkIfAccountExsist(user!.uid.toString());
        if(haveRegistered){
          print('provider-already-linked');
          print('Hogaya Hai');
          await _auth.signInWithCredential(authCredential);
          otpTextEditingController.text = authCredential.smsCode.toString();
          print("SMS CODE SEND BY BACKEND TO MOBILE SCREEN");
          print(authCredential.smsCode.toString());
          await Future.delayed(const Duration(seconds: 2), () {});
          ProgressDialog.hide();
          /*userSessionModel.phoneNumber =
              number!.dialCode! + phoneNumberTextEditingController.text;
          userSessionModel.photoURL = null;
          userSessionModel.firebaseUserId = _auth.currentUser?.uid.toString();
          await prefs.setString(
              "phoneNumber", userSessionModel.phoneNumber.toString());*/
          print("Your Phone Number is");
          print(await prefs.getString("phoneNumber"));
          Get.offAll(WelcomeBackScreen());
        }
        else{
          print("TERMN saas- 0");
          Get.offAll(CompleteRegistration1Screen());
        }
        return;
      } else {
        print("Something else");
        print('STILL IN MOBILE NUMBER SCREEN');
        await _auth.signInWithCredential(authCredential);
        otpTextEditingController.text = authCredential.smsCode.toString();
        ProgressDialog.hide();
        await Future.delayed(const Duration(seconds: 2), () {});
        /*userSessionModel.phoneNumber =
            number!.dialCode! + phoneNumberTextEditingController.text;
        userSessionModel.photoURL = null;
        userSessionModel.firebaseUserId = _auth.currentUser?.uid.toString();*/
        await prefs.setString("phoneNumber", number!.dialCode! + phoneNumberTextEditingController.text.toString());
        print("Your Phone Number is");
        print(await prefs.getString("phoneNumber"));
        print("_auth.currentUser?.uid.toStasasring()");
        print(_auth.currentUser?.uid.toString());
        print(await _auth.currentUser?.uid.toString());
        print("userSessionModel.firebaseUserId");
       /// print(userSessionModel.firebaseUserId);
        print("TERMN - 0");
        Get.offAll(CompleteRegistration1Screen());
        return;
      }
    }
    await _auth.signInWithCredential(authCredential);
    otpTextEditingController.text = authCredential.smsCode.toString();
    ProgressDialog.hide();
    await Future.delayed(const Duration(seconds: 2), () {});
    /*userSessionModel.phoneNumber =
        number!.dialCode! + phoneNumberTextEditingController.text;
    userSessionModel.photoURL = null;
    userSessionModel.firebaseUserId = _auth.currentUser?.uid.toString();*/
    print("_auth.currentUser?.uid.toStringasas()");
    print(_auth.currentUser?.uid.toString());
    print(await _auth.currentUser?.uid.toString());
    print("userSessionModel.firebaseUserId");
    await prefs.setString("phoneNumber", number!.dialCode! + phoneNumberTextEditingController.text.toString());
    print("Your Phone Number is");
    print(await prefs.getString("phoneNumber"));
    //print(userSessionModel.firebaseUserId);
    print("TERMN - 012");
    Get.offAll(CompleteRegistration1Screen());
    setState(() {
      print("Verification Completed");
      //this.otpTextEditingController.text = authCredential.smsCode;
    });
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      print("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    //this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
    print(verificationId);
    verifyID = verificationId;
    ProgressDialog.hide();
    print("Inside Code Sent Hook Event");
    print('STILL IN MOBILE NUMBER SCREEN');
    setState(() {
      isCodeNotSend = true;
    });
  }

  _onCodeTimeout(String timeout) {
    ProgressDialog.hide();
    return null;
  }

  Future<void> VerifyFirebaseOtp(String otp) async {
    ProgressDialog.show(context, "Please Wait");

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verifyID, smsCode: otp);
    // Sign the user in (or link) with the credential

    try {
      if (user != null) {
        UserCredential credential = await user!.linkWithCredential(authCredential);
        print("Kya bolu");
      } else {
        print("Somethiong else");
        await _auth.signInWithCredential(authCredential);
        otpTextEditingController.text = authCredential.smsCode.toString();
        ProgressDialog.hide();
        await Future.delayed(const Duration(seconds: 2), () {});
        /*userSessionModel.phoneNumber =
            number!.dialCode! + phoneNumberTextEditingController.text;
        userSessionModel.photoURL = null;*/
        print("_auth.currentUssasasasasasasasasasasasasasasasasasasasasasaer?.uid.toString()");
        print(_auth.currentUser?.uid.toString());
        print(await _auth.currentUser?.uid.toString());
        /*await prefs.setString(
            "phoneNumber", userSessionModel.phoneNumber.toString());
        print("Your Phone Number is");
        print(await prefs.getString("phoneNumber"));
        print("userSessionModel.firebaseUserId");
        print(userSessionModel.firebaseUserId);*/
        print("TERMN - 02121");
        Get.offAll(CompleteRegistration1Screen());
        Get.offAll(CompleteRegistration1Screen());
        return;
      }
    } on FirebaseAuthException catch (e) {
      print("e.code");
      print(e.code);

      if (e.code == 'provider-already-linked') {
        print('provider-already-linked');
        print('Kuch Toh');
        await _auth.signInWithCredential(authCredential);
        otpTextEditingController.text = authCredential.smsCode.toString();
        await Future.delayed(const Duration(seconds: 2), () {});
        ProgressDialog.hide();
        /*userSessionModel.phoneNumber =
            number!.dialCode! + phoneNumberTextEditingController.text;
        userSessionModel.photoURL = null;
        userSessionModel.firebaseUserId = _auth.currentUser?.uid.toString();
        await prefs.setString(
            "phoneNumber", userSessionModel.phoneNumber.toString());*/
        print("Your Phone Number is");
        print(await prefs.getString("phoneNumber"));
        print("userSessionModel.firebaseUserId");
        print("_auth.currentUser?.asasasuid.toString()");
        print(_auth.currentUser?.uid.toString());
        print(await _auth.currentUser?.uid.toString());
/*        print(userSessionModel.firebaseUserId);*/
        Get.offAll(WelcomeBackScreen());
      } else {
        print("Somethiong else");
        await _auth.signInWithCredential(authCredential);
        otpTextEditingController.text = authCredential.smsCode.toString();
        ProgressDialog.hide();
        await Future.delayed(const Duration(seconds: 2), () {});
        /*userSessionModel.phoneNumber =
            number!.dialCode! + phoneNumberTextEditingController.text;
        userSessionModel.photoURL = null;*/
        print(
            "_auth.currentUssasasasasasasasasasasasasasasasasasasasasasaer?.uid.toString()");
        print(_auth.currentUser?.uid.toString());
        print(await _auth.currentUser?.uid.toString());
        await prefs.setString(
            "phoneNumber", number!.dialCode! + phoneNumberTextEditingController.text.toString());
        print("Your Phone Number is");
        print(await prefs.getString("phoneNumber"));
        print("userSessionModel.firebaseUserId");
        //print(userSessionModel.firebaseUserId);print("TERMN -da 0");

        Get.offAll(CompleteRegistration1Screen());
      }
    }
    //verifyOtp(widget.userPhoneNumber.toString(), widget.otp.toString());
    //_auth.verifyPhoneNumber(phoneNumber: phoneNumber, verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
  }
}
