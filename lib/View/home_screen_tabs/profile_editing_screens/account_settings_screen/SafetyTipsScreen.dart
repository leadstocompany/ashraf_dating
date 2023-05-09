import 'package:flutter/material.dart';

class SafetyTipsScreen extends StatefulWidget {
  const SafetyTipsScreen({Key? key}) : super(key: key);

  @override
  State<SafetyTipsScreen> createState() => _SafetyTipsScreenState();
}

class _SafetyTipsScreenState extends State<SafetyTipsScreen> {


  List<Map<String,String>> safetyTipsStrings = [
    {"Be cautious with personal information:":"Avoid sharing personal information like your full name, address, phone number, or other identifying details until you feel comfortable and have built trust with the other person."},
    {"Meet in public places:":"When meeting someone for the first time, choose a public location that is well-lit and has other people around. This can help ensure your safety and make you feel more comfortable."},
    {"Trust your instincts:":"If you feel uncomfortable or unsafe with someone, trust your gut and end the conversation or meeting. Your safety should always come first."},
    {"Use video chat before meeting in person:":"Consider using video chat to talk with someone before meeting in person. This can help you get a better sense of who they are and build trust before meeting face-to-face."},
    {"Don't feel pressured: ":"You should never feel pressured to do anything you're not comfortable with. If someone is pressuring you to do something you don't want to do, end the conversation or meeting."},
    {"Report any suspicious behavior:":"If you encounter any suspicious behavior on the app, report it to the app's support team. This can help keep the community safe and prevent others from being victimized."},
    {"Be mindful of your surroundings": "Always be aware of your surroundings and take steps to ensure your safety, such as carrying a phone with you and letting a friend know where you're going and when you'll be back.If you encounter any suspicious behavior on the app, report it to the app's support team. This can help keep the community safe and prevent others from being victimized."}
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
        itemCount: safetyTipsStrings.length,
        itemBuilder: (c,i){
          return Container(
            
            
            child:RichText(
              text: TextSpan(
                  text: (i+1).toString()+". "+safetyTipsStrings[i].keys.first,
                  style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(text: safetyTipsStrings[i].values.first,
                    )
                  ]
              ),
            ),
          );
        },
      ),
    );
  }
}
