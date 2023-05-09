import 'package:flutter/material.dart';

class CommunityGuidelinesScreen extends StatefulWidget {
  const CommunityGuidelinesScreen({Key? key}) : super(key: key);

  @override
  State<CommunityGuidelinesScreen> createState() => _CommunityGuidelinesScreenState();
}

class _CommunityGuidelinesScreenState extends State<CommunityGuidelinesScreen> {


  List<Map<String,String>> communityGuidelinesString = [
    {"Be Respectful":"Treat all members with kindness and respect, regardless of their gender, sexual orientation, or identity. Harassment, hate speech, and discrimination will not be tolerated. This includes sending unsolicited sexual content to your matches.  "},
    {"Be Inclusive":"Fluid is a space for everyone, regardless of their background or identity. We celebrate diversity and welcome people from all walks of life."},
    {"Keep it Safe":"We take safety seriously at Fluid, and we expect all members to do the same. Please report any suspicious or inappropriate behavior to our team immediately."},
    {"Protect your privacy":"Be mindful of the personal information you share with others on Fluid. We recommend that you avoid sharing sensitive information like your full name, home address, or phone number."},
    {"Follow the law":"Fluid is committed to upholding the law and expects all members to do the same. Please do not engage in any illegal activity on our platform. Promoting or advocating for commercial sexual services, human trafficking or other non-consensual sexual acts is strictly prohibited.Any fraudulent or illegal activities will result in being reported to authorities and banning of the account."},
    {"Use common sense":"Ultimately, we want Fluid to be a positive and enjoyable experience for everyone. Please use common sense and good judgment when interacting with others."}
  ];

  String welcomeText = "Welcome to Fluid, a community designed to connect and empower people of all genders, sexual orientations, and identities. Our community is founded on the principles of respect, inclusivity, and safety, and we expect all members to uphold these values at all times. By using Fluid, you agree to abide by the following community guidelines:";

  String endingText = "We reserve the right to remove any content or suspend any member who violates these guidelines or engages in any behavior that we deem inappropriate or harmful to our community. By using Fluid, you agree to abide by these guidelines and help us maintain a safe and welcoming community for all.";


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
        title: Text("Community guidliness",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: communityGuidelinesString.length,
        itemBuilder: (c,i){
          if(i==0){
            return Column(
              children: [
                ListTile(
                  subtitle: Text(welcomeText),
                ),
                ListTile(
                  title: Text((i+1).toString()+". "+communityGuidelinesString[i].keys.first),
                  subtitle: Text(communityGuidelinesString[i].values.first),
                )
              ],
            );
          }
          else if(i==communityGuidelinesString.length){
            return Column(
              children: [
                ListTile(
                  title: Text((i+1).toString()+". "+communityGuidelinesString[i].keys.first),
                  subtitle: Text(communityGuidelinesString[i].values.first),
                ),
                ListTile(
                  subtitle: Text(endingText),
                ),
              ],
            );
          }
          else{
            return ListTile(
              title: Text((i+1).toString()+". "+communityGuidelinesString[i].keys.first),
              subtitle: Text(communityGuidelinesString[i].values.first),
            );
          }
        },
      ),
    );
  }
}
