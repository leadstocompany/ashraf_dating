import 'package:fluid_dating_app/View/MessageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../globals.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {



  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.black45,
            indicatorColor: customSelectionColorOfApp,
            tabs: [
              Padding(padding: const EdgeInsets.only(top: 12, bottom: 12), child: Text('All')),
              Padding(padding: const EdgeInsets.only(top: 12, bottom: 12), child: Text('Events')),
            ],
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text("Discover",style: Theme.of(context).textTheme.headlineSmall,),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Mark all as read",style: TextStyle(color: customSelectionColorOfApp),
              )
            )
          ],
        ),
        body:TabBarView(
          children: [
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10),
              separatorBuilder: (c,i){
                return Divider();
              },
              itemBuilder: (c,i){
                return Container(

                  child: ListTile(

                      onTap: (){
                        Get.to(MessageScreen());
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("https://flxt.tmsimg.com/assets/283805_v9_ba.jpg"),
                      ),
                      title: Row(
                        children: [
                          Text("Jaaneman",style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                          Text(" liked a photo"),
                        ],
                      ),
                      trailing: Text("2 Mins Ago")
                  ),
                );
              },
              itemCount: 3,
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10),
              separatorBuilder: (c,i){
                return Divider();
              },
              itemBuilder: (c,i){
                return Container(

                  child: ListTile(

                      onTap: (){

                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("https://www.usmagazine.com/wp-content/uploads/2019/06/Taylor-Swift-You-Need-To-Calm-Down-Video-02.jpg?quality=86&strip=all"),
                      ),
                      title: Row(
                        children: [
                          Text("Delhi Pride :",style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                          Text(" Event Reminder"),
                        ],
                      ),
                      trailing: Text("2 Mins Ago")
                  ),
                );
              },
              itemCount: 3,
            ),
          ],
        )
      ),
    );
  }
}
