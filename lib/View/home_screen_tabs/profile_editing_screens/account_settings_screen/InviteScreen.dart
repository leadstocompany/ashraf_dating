import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height*0.1,),
            Text("Invite your friends and help us grow!",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.black,fontWeight: FontWeight.w500
            ),),
            SizedBox(height: size.height*0.2,),
            ElevatedButton.icon(
              icon:  FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
              ),
              onPressed: (){},
              label: Text(
                "Invite Via Whatsapp",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                fixedSize: const Size(208, 43),
              ),
            ),
            SizedBox(height: size.height*0.1,),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple,
                    Colors.pink,
                    Colors.orange,
                  ],
                ),
              ),
              child: ElevatedButton.icon(
                icon: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                ),
                onPressed: (){},
                label: Text(
                  "Invite Via Instagram",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(

                  primary: Colors.transparent,
                  fixedSize: const Size(208, 43),
                ),
              ),
            ),
            SizedBox(height: size.height*0.25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black
                  ),// <-- TextButton
                  onPressed: () {

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Copied to clipboard'),
                    ));
                    Clipboard.setData(new ClipboardData(text: 'https://funkaara.in/'));
                  },
                  icon: Icon(
                    Icons.copy,
                    size: 24.0,
                  ),
                  label: Text('Copy Link'),
                ),
                Container(height: 20,width: 1,color: Colors.black,),
                TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black
                  ),//// <-- TextButton
                  onPressed: () {
                    Share.share('Checkout Vervo...', subject: 'https://funkaara.in/');
                  },
                  icon: Icon(
                    Icons.share,
                    size: 24.0,
                  ),
                  label: Text('More Options'),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
