import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {


  List<Map<String,String>> termsAndConditionsString = [
    {"ACCEPTANCE OF TERMS":"Welcome to Verve, an LGBTQ+ dating app! These Terms and Conditions (“Terms”) govern your use of our app, our website, and any other services or products we offer (collectively, the “Service”). By accessing or using the Service, you agree to be bound by these Terms, our Privacy Policy, and all applicable laws and regulations."},
    {"DESCRIPTION OF SERVICE":"Verve is a dating app designed for the LGBTQ+ community, where users can create a profile, match with other users, and communicate through the app’s messaging system."},
    {"USER CONDUCT":"By using Verve, you agree to conduct yourself in a respectful and appropriate manner. You agree to use the Service only for lawful purposes and in accordance with these Terms. Specifically, you agree not to:\n• Use the Service in any way that violates any applicable federal, state, local, or international law or regulation.\n• Use the Service to engage in any conduct that restricts or inhibits anyone’s use or enjoyment of the Service, or which, as determined by us, may harm Verve or users of the Service or expose them to liability.\n• Use the Service to impersonate any person or entity, or falsely state or otherwise misrepresent your affiliation with a person or entity.\n• Engage in any other conduct that restricts or inhibits anyone’s use or enjoyment of the Service, or which, as determined by us, may harm Verve or users of the Service or expose them to liability."},
    {"ACCOUNT REGISTRATION AND SECURITY":"In order to use Verve, you must create an account with us. You agree to provide accurate and complete information when you create your account, and to update your account information as necessary. You are responsible for maintaining the confidentiality of your account information, including your password, and for all activity that occurs under your account."},
    {"PROPRIETARY RIGHTS":"The Service and its entire contents, features, and functionality (including but not limited to all information, software, text, displays, images, video, and audio, and the design, selection, and arrangement thereof), are owned by Verve, its licensors, or other providers of such material and are protected by United States and international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws."},
    {"DISCLAIMER OF WARRANTIES":"The Service is provided on an “as is” and “as available” basis, without any warranties of any kind, either express or implied. Verve disclaims all warranties, express or implied, including but not limited to implied warranties of merchantability, fitness for a particular purpose, and non-infringement. We do not warrant that the Service will be uninterrupted or error-free, that defects will be corrected, or that the Service or the server that makes it available are free of viruses or other harmful components."},
    {"LIMITATION OF LIABILITY":"In no event shall Verve, its affiliates, or their licensors, service providers, employees, agents, officers, or directors be liable for damages of any kind, including without limitation any direct, indirect, special, incidental, punitive, or consequential damages, arising out of or in connection with the use or inability to use the Service or any content posted, transmitted, or otherwise made available via the Service."},
    {"MODIFICATIONS TO SERVICE":"We reserve the right to modify or discontinue, temporarily or permanently, the Service (or any part thereof) with or without notice. We shall not be liable to you or to any third party for any modification, suspension, or discontinuance of the Service."},
    {"INDEMNIFICATION":"You agree to indemnify and hold Verve, and its affiliates, officers, agents, employees, and partners harmless from and against any and all claims, liabilities, damages (actual and consequential), losses, and expenses (including attorneys' fees) arising from or in any way related to your use of the Verve app, including any content or data submitted by you or transmitted through your account, your violation of these terms, or your violation of any rights of another. This indemnification obligation will survive these terms and your use of the app."},
  ];
  

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
        title: Text("Terms and Conditions",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: termsAndConditionsString.length,
        itemBuilder: (c,i){



          return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 17.0,top: 20),
              child: Text((i+1).toString()+". "+termsAndConditionsString[i].keys.first,
            )),
            subtitle: Text(termsAndConditionsString[i].values.first),
          );
        },
      ),
    );
  }
}
