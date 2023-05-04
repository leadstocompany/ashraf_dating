import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteRegistration3Screen extends StatefulWidget {
  const CompleteRegistration3Screen({Key? key}) : super(key: key);

  @override
  State<CompleteRegistration3Screen> createState() => _CompleteRegistration3ScreenState();
}

class _CompleteRegistration3ScreenState extends State<CompleteRegistration3Screen> {


  TextEditingController emailTextEditingController = TextEditingController();

  var professionList = <String>['Actress', 'Singer', 'Director', 'Producer'];
  String? profession = 'Actress';


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableWidgets().FluidHeaderText("Add Your Photos",context),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.06, top: size.width * 0.04),
              child: DropdownButton<String>(
                value: profession,
                style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline6,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                underline: Container(
                    height: 1.0,
                   decoration: const BoxDecoration(
                       border: Border(
                             bottom: BorderSide(
                                color: Colors.transparent, width: 0.0))),
                   ),
                icon: Icon(Icons.keyboard_arrow_down),
                items: professionList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
            ReusableWidgets().FluidButton("NEXT", (){


              Get.to(CompleteRegistration3Screen());


            }, context),

          ],
        ),
      ),
    );


  }
}