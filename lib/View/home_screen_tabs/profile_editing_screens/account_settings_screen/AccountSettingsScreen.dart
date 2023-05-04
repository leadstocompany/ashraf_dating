import 'package:fluid_dating_app/View/home_screen_tabs/profile_editing_screens/account_settings_screen/CommunityGuidelinesScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              ListTile(
                title: Text("Account Activity",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
              ),
              Divider(),
              ListTile(
                title: Text("Change your password"),
              ),
              Divider(),
              ListTile(
                title: Text("Subscription plan"),
              ),
              Divider(),
              ListTile(
                title: Text("Blocked list"),
              ),
              Divider(),
              ListTile(
                title: Text("Suggestions"),
              ),
              Divider(),
              ListTile(
                title: Text("Pause my account"),
              ),
              Divider(),
              ListTile(
                title: Text("Delete my account"),
              ),

              SizedBox(height: 30,),
              ListTile(
                title: Text("Notifications",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
              ),
              Divider(),
              ListTile(
                title: Text("Message notifications"),
              ),
              Divider(),
              ListTile(
                title: Text("Match notifications"),
              ),
              Divider(),
              ListTile(
                title: Text("Other notifications"),
              ),

              SizedBox(height: 30,),
              ListTile(
                title: Text("Community",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
              ),
              Divider(),
              ListTile(
                onTap: (){
                  Get.to(CommunityGuidelinesScreen());
                },
                title: Text("Community guidelines"),
              ),
              Divider(),
              ListTile(
                title: Text("Safety tips"),
              ),


              SizedBox(height: 30,),
              ListTile(
                title: Text("Help & Support",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
              ),
              Divider(),
              ListTile(
                title: Text("FAQ"),
              ),
              Divider(),
              ListTile(
                title: Text("Resources"),
              ),
              Divider(),
              ListTile(
                title: Text("Support centre"),
              ),

              SizedBox(height: 30,),
              ListTile(
                title: Text("Privacy",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
              ),
              Divider(),
              ListTile(
                title: Text("Privacy policy"),
              ),
              Divider(),
              ListTile(
                title: Text("Terms & Conditions"),
              ),
              Divider(),
              ListTile(
                title: Text("Cookie policy"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
