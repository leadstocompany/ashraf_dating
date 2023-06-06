import 'package:flutter/material.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {


  List<Map<String,String>> communityGuidelinesString = [
    {"The Humsafar Trust":"Treat all members with kindness and respect, regardless of their gender, sexual orientation, or identity. Harassment, hate speech, and discrimination will not be tolerated. This includes sending unsolicited sexual content to your matches.  "},
    {"Naz Foundation":"Fluid is a space for everyone, regardless of their background or identity. We celebrate diversity and welcome people from all walks of life."},
    {"The Pink Pages":"We take safety seriously at Fluid, and we expect all members to do the same. Please report any suspicious or inappropriate behavior to our team immediately."},
    {"Ya_All":"Be mindful of the personal information you share with others on Fluid. We recommend that you avoid sharing sensitive information like your full name, home address, or phone number."},
    {"Queerala":"Fluid is committed to upholding the law and expects all members to do the same. Please do not engage in any illegal activity on our platform. Promoting or advocating for commercial sexual services, human trafficking or other non-consensual sexual acts is strictly prohibited.Any fraudulent or illegal activities will result in being reported to authorities and banning of the account."},
  ];

  String welcomeText = "Directory of LGBTQ+ organizations and support groups in India:";

  String endingText = "We reserve the right to remove any content or suspend any member who violates these guidelines or engages in any behavior that we deem inappropriate or harmful to our community. By using Fluid, you agree to abide by these guidelines and help us maintain a safe and welcoming community for all.";
  String endingText2 = "List of hotlines and crisis resources for those who need immediate help:Mental Health:";

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

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
        title: Text("India",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: communityGuidelinesString.length,
        itemBuilder: (c,i){
          if(i==0){
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height*0.02),
                  child: ListTile(
                    subtitle: Text(welcomeText),
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: height*0.01),
                    child: Text((i+1).toString()+". "+communityGuidelinesString[i].keys.first),
                  ),
                  subtitle: Text(communityGuidelinesString[i].values.first),
                )
              ],
            );
          }
          else if(i==communityGuidelinesString.length){
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height*0.05),                  child: ListTile(
                  title: Text((i+1).toString()+". "+communityGuidelinesString[i].keys.first),
                  subtitle: Text(communityGuidelinesString[i].values.first),
                ),
                ),
                ListTile(
                  subtitle: Text(endingText),
                ),
              ],
            );
          }
          else{
            return Container(
              padding: EdgeInsets.symmetric(vertical: height*0.01),
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: height*0.01),
                  child: Text((i+1).toString()+". "+communityGuidelinesString[i].keys.first),
                ),
                subtitle: Text(communityGuidelinesString[i].values.first),
              ),
            );
          }
        },
      ),
    );
  }
}
