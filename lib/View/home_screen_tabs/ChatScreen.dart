import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/View/MessageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  List<Widget> myMatches = [];

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    myMatches = [
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQblStGxDfLur0q2UNddY9jlZRqGGuAanrh_wUH-2G9eTdbogYyhGERaNq6xS_S6eqoEKEc_Fm-C4I&usqp=CAU&ec=48665701', fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Avril_Lavigne_in_Hongkong_Press_cropped.jpg/1200px-Avril_Lavigne_in_Hongkong_Press_cropped.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://i2-prod.mirror.co.uk/incoming/article29490942.ece/ALTERNATES/s1200b/0_Opening-Night-of-Taylor-Swift-The-Eras-Tour.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQblStGxDfLur0q2UNddY9jlZRqGGuAanrh_wUH-2G9eTdbogYyhGERaNq6xS_S6eqoEKEc_Fm-C4I&usqp=CAU&ec=48665701', fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Avril_Lavigne_in_Hongkong_Press_cropped.jpg/1200px-Avril_Lavigne_in_Hongkong_Press_cropped.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://i2-prod.mirror.co.uk/incoming/article29490942.ece/ALTERNATES/s1200b/0_Opening-Night-of-Taylor-Swift-The-Eras-Tour.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQblStGxDfLur0q2UNddY9jlZRqGGuAanrh_wUH-2G9eTdbogYyhGERaNq6xS_S6eqoEKEc_Fm-C4I&usqp=CAU&ec=48665701', fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Avril_Lavigne_in_Hongkong_Press_cropped.jpg/1200px-Avril_Lavigne_in_Hongkong_Press_cropped.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(right:10,),
        width: size.width*0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Image border
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: Image.network('https://i2-prod.mirror.co.uk/incoming/article29490942.ece/ALTERNATES/s1200b/0_Opening-Night-of-Taylor-Swift-The-Eras-Tour.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 30,right: 30,top: 30),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage("https://flxt.tmsimg.com/assets/283805_v9_ba.jpg"),radius: 25,),
                SizedBox(width: 20,),
                ReusableWidgets().FluidBoldHeaderText("Megan Fox", context, false)
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: size.height*0.01,top: size.height*0.03),
            child: ReusableWidgets().FluidBoldMediumSubHeaderText("Your Matches", context, false),),
            Container(
              height: size.height*0.15,
              child: ListView.builder(
                itemCount: myMatches.length,
                itemBuilder: (c,i){
                  return myMatches[i];
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            /*Container(
              height: size.height*0.03,
              margin: EdgeInsets.symmetric(vertical: size.height*0.01),
              padding: EdgeInsets.symmetric(horizontal: size.width*0.3,vertical: size.height*0.01),

              child:ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: myMatches.length,
                itemBuilder: (c,i){
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(radius: 2,backgroundColor: Theme.of(context).primaryColor,),
                  );
                },
              ),

            ),*/
            Container(
              height: size.height*0.01,
              margin: EdgeInsets.symmetric(vertical: size.height*0.01),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (c,i){
                  return Padding(
                    padding: EdgeInsets.only(left: size.width*0.15),
                    child: Divider(),
                  );
                },
                itemBuilder: (c,i){
                  return Container(

                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      onTap: (){
                        Get.to(MessageScreen());
                      },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("https://flxt.tmsimg.com/assets/283805_v9_ba.jpg"),
                        ),
                        title: Text("Jaaneman",style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        subtitle: Text("Patte se maarungi....",),
                        trailing: Text("2 Mins Ago")
                    ),
                  );
                },
                itemCount: 20,
              ),
            ),
          ],
        )
      ),
    );
  }
}
