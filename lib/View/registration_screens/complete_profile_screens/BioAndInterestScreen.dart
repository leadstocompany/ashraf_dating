import 'package:fluid_dating_app/View/HomeScreenTab.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration3Screen.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration7Screen.dart';
import 'package:fluid_dating_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../Helper/reusable_widgets.dart';
import '../../home_screen_tabs/profile_editing_screens/EditProfileScreen.dart';

class BioAndInterestScreen extends StatefulWidget {
  const BioAndInterestScreen({Key? key}) : super(key: key);

  @override
  State<BioAndInterestScreen> createState() => _BioAndInterestScreenState();
}

class _BioAndInterestScreenState extends State<BioAndInterestScreen> {
  TextEditingController bioTextEditingController = TextEditingController();
  TextEditingController dreamsTextEditingController = TextEditingController();

  final List<Data> _choiceChipsList = [
    Data("Photography", Colors.green),
    Data("Music", Colors.blue),
    Data("Book", Colors.deepOrange),
    Data("Gaming", Colors.cyan),
    Data("Fashion", Colors.pink),
    Data("Architecture", Colors.pink),
  ];

  List<String> selectedIntrests = [];

  int? _selectedIndex;

  bool makeBioVisible = true;
  bool makeDreamsVisible = true;
  bool makeInterestVisible = true;

  bool makeInterestChipVisible= false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,iconTheme: IconThemeData(color: primaryColorOfApp),),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*0.02,),
              ReusableWidgets().FluidHeaderText("Complete your Profile",context),
              SizedBox(height: size.height*0.05,),
              Flexible(
                child: ListView(
                  primary: true,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Visibility(
                        visible: makeBioVisible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableWidgets().FluidBoldSubHeaderText("Add Bio", context, false),
                        ReusableWidgets().FluidTextField("", "", context, bioTextEditingController, false, false, () => null, false,null,(!makeInterestVisible?30:7),(){
                          makeDreamsVisible = false;
                          makeInterestVisible = false;
                          makeBioVisible = true;
                          print("Joal");
                          setState(() {

                          });
                        }),
                        SizedBox(height: 40,),
                      ],
                    )),
                    Visibility(
                      visible: makeInterestVisible,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ReusableWidgets().FluidBoldSubHeaderText(makeDreamsVisible?"Your interests":"Interests/Hobbies", context, false),
                          SizedBox(height: 10,),
                          ReusableWidgets().FluidNoteText("Share your interests with the community. Tell us about the things that bring you joy and make you unique. (You can select multiple: Up-to 7)", context),
                          SizedBox(height: 10,),
                          Visibility(child: ReusableWidgets().FluidTextField("", "", context, TextEditingController(),false,false,null,false,Icon(Icons.add_circle_outline,color: primaryColorOfApp,),null,(){
                            makeDreamsVisible = false;
                            makeInterestVisible = true;
                            makeBioVisible = false;
                            makeInterestChipVisible = true;
                            print("gr");
                            setState(() {

                            });
                            print(makeDreamsVisible);
                            print(makeInterestVisible);
                            print(makeBioVisible);
                          },),visible: !makeInterestChipVisible,),
                          Visibility(child: Wrap(
                            spacing: 10,
                            direction: Axis.horizontal,
                            children: choiceChips(),
                          ),visible: makeInterestChipVisible,),
                          SizedBox(height: 40,),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: makeDreamsVisible,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ReusableWidgets().FluidBoldSubHeaderText("My Dreams", context, false),
                        SizedBox(height: 10,),
                        ReusableWidgets().FluidNoteText("Dreams Bring Us Closer Together", context),
                        SizedBox(height: 10,),
                        ReusableWidgets().FluidTextField("", "", context, dreamsTextEditingController, false, false, () => null, false,null,!makeInterestVisible?30:7,(){
                          makeDreamsVisible = true;
                          makeInterestVisible = false;
                          makeBioVisible = false;
                          print("saasas");
                          setState(() {

                          });
                        }),
                      ],
                    ),),
                    SizedBox(height: 20,),
                    ReusableWidgets().FluidButton((!makeInterestVisible||!makeBioVisible||!makeDreamsVisible)?"Update":"NEXT", (){

                      if(makeInterestVisible && makeBioVisible && makeDreamsVisible){
                        Get.to(HomeScreenTab());
                      }
                      else {
                        makeDreamsVisible = true;
                        makeInterestVisible = true;
                        makeBioVisible = true;
                        setState(() {

                        });
                      }


                    }, context),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ChoiceChip(
          label: Text(_choiceChipsList[i].label),
          labelStyle: TextStyle(color: selectedIntrests.contains(_choiceChipsList[i].label)?Colors.white:Colors.black),
          shape: StadiumBorder(side: BorderSide(color: Theme.of(context).primaryColor)),
          //backgroundColor: _choiceChipsList[i].color,
          backgroundColor: Colors.white,
          selected: selectedIntrests.contains(_choiceChipsList[i].label),
          selectedColor: Theme.of(context).primaryColor,
          onSelected: (bool value) {
            setState(() {
              _selectedIndex = i;

              if(selectedIntrests.contains(_choiceChipsList[i].label)){
                selectedIntrests.remove(_choiceChipsList[i].label);
              }
              else{
                selectedIntrests.add(_choiceChipsList[i].label);
              }


            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
