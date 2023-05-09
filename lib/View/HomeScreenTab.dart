import 'package:fluid_dating_app/View/home_screen_tabs/ChatScreen.dart';
import 'package:fluid_dating_app/View/home_screen_tabs/HomeScreen.dart';
import 'package:fluid_dating_app/View/home_screen_tabs/NotificationScreen.dart';
import 'package:fluid_dating_app/View/home_screen_tabs/ProfileScreen.dart';
import 'package:fluid_dating_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {

  int pageIndex = 1;

  List pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      ProfileScreen(notifyParent: refresh,),
      ChatScreen(),
      NotificationScreen(),
      HomeScreen(),
    ];
  }



  @override
  Widget build(BuildContext context) {



    var size = MediaQuery.of(context).size;

    print("Page Index"+pageIndex.toString());
    print("Page"+pages[pageIndex].toString());


    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            body: pages[pageIndex],
            bottomNavigationBar: buildMyNavBar(context),
          ),
        ),
        onWillPop: _onWillPop);
  }

  refresh() {
    setState(() {});
  }

  Container buildMyNavBar(BuildContext context) {

    /*print(Theme.of(context).primaryColor == Colors.white);
    print("Hola Kuch");
    print(Theme.of(context));
    print(Themes().wingWhiteOnBlackTheme);
    print(Themes().wingsBlackOnWhiteTheme);

    if(Theme.of(context).primaryColor == Colors.white){
      isWhiteOnBlackTheme = true;
    }*/

    return Container(
      height: MediaQuery.of(context).size.height*0.086,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Get.isDarkMode ?Colors.black : Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
          //  enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            child: Column(
                  children: [
                    Icon(Icons.person_outline_outlined, color:pageIndex == 0?primaryColorOfApp:Colors.grey , size: 30,),
                    Text("Profile",style: TextStyle(color: pageIndex == 0?primaryColorOfApp:Colors.grey),)
                  ],
                )
          ),
          TextButton(
            //  enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: Column(
                children: [
                  Icon(Icons.chat_bubble_outline_outlined, color:pageIndex == 1?primaryColorOfApp:Colors.grey , size: 30,),
                  Text("Chats",style: TextStyle(color: pageIndex == 1?primaryColorOfApp:Colors.grey),)
                ],
              )
          ),
          TextButton(
            //  enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              child: Column(
                children: [
                  Icon(Icons.favorite_border_outlined, color:pageIndex == 2?primaryColorOfApp:Colors.grey , size: 30,),
                  Text("Notifications",style: TextStyle(color: pageIndex == 2?primaryColorOfApp:Colors.grey),)
                ],
              )
          ),
          TextButton(
            //  enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              child: Column(
                children: [
                  Icon(Icons.home_outlined, color:pageIndex == 3?primaryColorOfApp:Colors.grey , size: 30,),
                  Text("Home",style: TextStyle(color: pageIndex == 3?primaryColorOfApp:Colors.grey),)
                ],
              )
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    return Future.value(false);
  }

}
