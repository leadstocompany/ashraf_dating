import 'package:fluid_dating_app/View/MessageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {



  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text("Notifications",style: Theme.of(context).textTheme.headlineSmall,),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage:  NetworkImage("https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg"),
            ),
          )
        ],
      ),
      body: ListView.separated(
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
    );
  }
}
