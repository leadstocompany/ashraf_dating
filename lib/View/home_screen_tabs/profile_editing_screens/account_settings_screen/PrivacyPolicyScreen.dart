import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {


  List<Map<String,String>> privacyPolicyStrings = [
    {"Types of data we collect":"We may collect personal information from you, such as your name, email address, location, and other details you provide when you create an account or use our app. We may also collect data on your preferences, interests, and behaviors as you use our app."},
    {"Use of your personal data":"We use the information we collect to improve our app and provide you with a better user experience. We may also use your information to personalize your experience, to send you marketing communications, and to communicate with you about your account."},
    {"Disclosure of your personal data":"We do not sell or rent your personal information to third parties. However, we may share your information with third-party service providers who help us provide our services, such as payment processors or analytics providers."},
  ];

  String welcomeText = "Welcome to Fluid, a community designed to connect and empower people of all genders, sexual orientations, and identities. Our community is founded on the principles of respect, inclusivity, and safety, and we expect all members to uphold these values at all times. By using Fluid, you agree to abide by the following community guidelines:";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,),
        ),
        backgroundColor: Colors.white,
        title: Text("Privacy Policy",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: privacyPolicyStrings.length,
        itemBuilder: (c,i){
          if(i==0){
            return Column(
              children: [
                ListTile(
                  subtitle: Text(welcomeText),
                ),
                ListTile(
                  title: Text((i+1).toString()+". "+privacyPolicyStrings[i].keys.first),
                  subtitle: Text(privacyPolicyStrings[i].values.first),
                )
              ],
            );
          }
          else if(i==privacyPolicyStrings.length){
            return Column(
              children: [
                ListTile(
                  title: Text((i+1).toString()+". "+privacyPolicyStrings[i].keys.first),
                  subtitle: Text(privacyPolicyStrings[i].values.first),
                ),
                ListTile(
                  subtitle: Text(welcomeText),
                ),
              ],
            );
          }
          else{
            return ListTile(
              title: Text((i+1).toString()+". "+privacyPolicyStrings[i].keys.first),
              subtitle: Text(privacyPolicyStrings[i].values.first),
            );
          }
        },
      ),
    );
  }
}
