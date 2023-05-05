import 'package:flutter/material.dart';

class CommunityGuidelinesScreen extends StatefulWidget {
  const CommunityGuidelinesScreen({Key? key}) : super(key: key);

  @override
  State<CommunityGuidelinesScreen> createState() => _CommunityGuidelinesScreenState();
}

class _CommunityGuidelinesScreenState extends State<CommunityGuidelinesScreen> {


  List<Map<String,String>> communityGuidelinesString = [
    {"Be Respectful":""},
    {"Be Inclusive":""},
    {"Keep it Safe":""},
    {"Protect your privacy":""},
    {"Follow the law":""},
    {"Use common sense":""}
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
                  subtitle: Text(welcomeText),
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
