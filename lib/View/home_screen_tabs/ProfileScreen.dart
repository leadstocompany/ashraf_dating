import 'package:fluid_dating_app/Helper/AppServices.dart';
import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/View/home_screen_tabs/profile_editing_screens/EditProfileScreen.dart';
import 'package:fluid_dating_app/View/home_screen_tabs/profile_editing_screens/account_settings_screen/AccountSettingsScreen.dart';
import 'package:fluid_dating_app/View/home_screen_tabs/profile_editing_screens/account_settings_screen/InviteScreen.dart';
import 'package:fluid_dating_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatefulWidget {

  Function() notifyParent;

  ProfileScreen({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {

  bool enablePushNotifications = false;
  bool enableDarkMode = false;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: customSelectionColorOfApp,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              )
            ),
            height:290,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("My Profile",style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage("https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg"),
                )
              ],
            ),
          ),
          Flexible(
            child: ListView(
              padding: EdgeInsets.all(10),
              primary: true,
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap:(){
                    Get.to(EditProfileScreen(profileName: "ashraf",));
                  },
                  leading: Icon(Icons.edit),
                  title: Text("Edit Profile"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AccountSettingsScreen()),
                      );*/
                    Get.to(AccountSettingsScreen());
                  },
                  leading: Icon(Icons.settings),
                  title: Text("Account settings"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(),
                ListTile(
                  onTap: (){
                    Get.to(InviteScreen());
                  },
                  leading: Icon(Icons.person_add_alt_1_rounded),
                  title: Text("Invite"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Divider(),
                PushNotificationToggle(),
                Divider(),
                DarkModeToggle(),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Log-out"),
                ),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }

  DarkModeToggle() {
    return CupertinoSwitchListTile(
      title: Text(
        'Dark Mode',
      ),
      value: enableDarkMode,
      activeColor:Theme.of(context).primaryColor,
      /*activeTrackColor:Theme.of(context).primaryColor.withOpacity(0.5),
      inactiveThumbColor:Colors.white,
      inactiveTrackColor:Colors.black.withOpacity(0.4),*/
      onChanged: (bool value) {

        enableDarkMode = value;
        AppServices().ChangeTheme(enableDarkMode);
       // setState(() {});
        widget.notifyParent();
      },
    );
  }

  PushNotificationToggle() {
    return CupertinoSwitchListTile(
      title: Text(
        'Push notifications',
      ),
      value: enablePushNotifications,
      activeColor:Theme.of(context).primaryColor,

      /*activeTrackColor:Theme.of(context).primaryColor.withOpacity(0.5),
      inactiveThumbColor:Colors.white,
      inactiveTrackColor:Colors.black.withOpacity(0.4),*/
      onChanged: (bool value) {
        setState(() {
          enablePushNotifications = value;
        });
      },
    );
  }
}