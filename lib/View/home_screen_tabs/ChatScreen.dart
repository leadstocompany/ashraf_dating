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

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 30,right: 30,top: 30),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage("https://flxt.tmsimg.com/assets/283805_v9_ba.jpg"),radius: 50,),
              SizedBox(width: 20,),
              ReusableWidgets().FluidBoldHeaderText("Megan Fox", context, false)
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.01),
          child: ReusableWidgets().FluidBoldSubHeaderText("Your Matches", context, false),),
          Container(
            height: size.height*0.3,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  padding: EdgeInsets.only(right:10,),
                  width: size.width*0.35,
                  height: size.height*0.3,
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
                  width: size.width*0.35,
                  height: size.height*0.3,
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
                  width: size.width*0.35,
                  height: size.height*0.3,
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
                  width: size.width*0.35,
                  height: size.height*0.3,
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
                  width: size.width*0.35,
                  height: size.height*0.3,
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
                  width: size.width*0.35,
                  height: size.height*0.3,
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
                  width: size.width*0.35,
                  height: size.height*0.3,
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
                  width: size.width*0.35,
                  height: size.height*0.3,
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
                  width: size.width*0.35,
                  height: size.height*0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: Image.network('https://i2-prod.mirror.co.uk/incoming/article29490942.ece/ALTERNATES/s1200b/0_Opening-Night-of-Taylor-Swift-The-Eras-Tour.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height*0.03,
            margin: EdgeInsets.symmetric(vertical: size.height*0.01),
            padding: EdgeInsets.symmetric(horizontal: size.width*0.3,vertical: size.height*0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(radius: 2,backgroundColor: Theme.of(context).primaryColor,),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(radius: 2,backgroundColor: Theme.of(context).primaryColor,),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(radius: 2,backgroundColor: Theme.of(context).primaryColor,),
                ),
              ],
            ),
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
                return ListTile(
                  onTap: (){
                    Get.to(MessageScreen());
                  },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("https://flxt.tmsimg.com/assets/283805_v9_ba.jpg"),radius: 30,
                    ),
                    title: Text("Jaaneman"),
                    subtitle: Text("Patte se maarungi...."),
                    trailing: Text("2 Mins Ago")
                );
              },
              itemCount: 20,
            ),
          ),
        ],
      )
    );
  }
}
