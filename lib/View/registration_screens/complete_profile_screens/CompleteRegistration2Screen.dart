import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/BioAndInterestScreen.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/FilterByScreenForRegistration.dart';
import 'package:fluid_dating_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CompleteRegistration3Screen.dart';
import 'CompleteRegistration4Screen.dart';

class CompleteRegistration2Screen extends StatefulWidget {
  const CompleteRegistration2Screen({Key? key}) : super(key: key);

  @override
  State<CompleteRegistration2Screen> createState() => _CompleteRegistration2ScreenState();
}

class _CompleteRegistration2ScreenState extends State<CompleteRegistration2Screen> {


  TextEditingController emailTextEditingController = TextEditingController();

  List<String> genderPreferences = [
    "Male",
    "Female",
    "Transgender",
    "Other"
  ];

  List<String> sexualIdentityPreferences = [
    "Male",
    "Female",
    "Transgender",
    "Non-Binary",
    "Other"
  ];



  TextEditingController sexualIdentityPreferenceTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sexualIdentityPreferenceTextEditingController.text = "Please Select...";
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,iconTheme: IconThemeData(color: primaryColorOfApp),),

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.02,),
                ReusableWidgets().FluidHeaderText("Please Select Your",context),
                SizedBox(height: size.height*0.05,),
                Text("Sexual Identity Preferences"),
                Visibility(
                    visible: _selectedItems.length>0,
                    child: SizedBox(height: size.height*0.01,)),
                Wrap(
                  children: _selectedItems
                      .map((e) => Container(
                    padding: EdgeInsets.only(right: 2),
                    child: Chip(
                      backgroundColor: primaryColorOfApp,
                      label: Text(e,style: TextStyle(color: Colors.white,fontSize: 12),),
                    ),
                  ))
                      .toList(),
                ),


                ReusableWidgets().FluidTextField("", "", context, sexualIdentityPreferenceTextEditingController,false,false,null,false,Icon(Icons.add_circle_outline,color: primaryColorOfApp,),null,(){_showMultiSelect();},true),
                SizedBox(height: size.height*0.05,),
                // display selected items                SizedBox(height: size.height*0.05,),
                Text("Gender Preferences"),
                Visibility(
                    visible: _selectedGenders.length>0,
                    child: SizedBox(height: size.height*0.01,)),
                Wrap(
                  children: _selectedGenders
                      .map((e) => Container(
                    padding: EdgeInsets.only(right: 2),
                    child: Chip(
                      backgroundColor: primaryColorOfApp,
                      label: Text(e,style: TextStyle(color: Colors.white,fontSize: 12),),
                    ),
                  ))
                      .toList(),
                ),

                ReusableWidgets().FluidTextField("", "", context, sexualIdentityPreferenceTextEditingController,false,false,null,false,Icon(Icons.add_circle_outline,color: primaryColorOfApp,),null,(){_showGenderMultiSelect();},true),

                SizedBox(height: size.height*0.3,),
                ReusableWidgets().FluidButton("NEXT", (){
                  Get.to(CompleteRegistration3Screen());
                }, context),
                SizedBox(height: size.height*0.05,),
              ],
            ),
          ),
        ),
      ),
    );


  }

  List<String> _selectedItems = [];
  List<String> _selectedGenders = [];

  void _showMultiSelect() async {

    _selectedItems = [];
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = sexualIdentityPreferences;


// This function is triggered when a checkbox is checked or unchecked
    void _itemChange(String itemValue, bool isSelected) {
      setState(() {
        if (isSelected) {
          _selectedItems.add(itemValue);
        } else {
          _selectedItems.remove(itemValue);
        }
      });
    }


    final List<String>? results = await showModalBottomSheet(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0),
              topLeft: Radius.circular(50.0),
            )),
        context: context,
        builder: (context) {

          var size = MediaQuery.of(context).size;

          return StatefulBuilder(
              builder: (context,innerState) {
                return Wrap(
                  children: [
                    Container(

                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Select Your Sexual Preferences",
                                  style: GoogleFonts.raleway(
                                      textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SingleChildScrollView(
                                child: ListBody(
                                  children: items
                                      .map((item) => CheckboxListTile(
                                    activeColor: primaryColorOfApp,
                                    value: _selectedItems.contains(item),
                                    title: Text(item),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    onChanged: (isChecked) {
                                      if(isChecked!){
                                        if(!_selectedItems.contains(item)){
                                          _selectedItems.add(item);
                                        }
                                      }
                                      else{
                                        _selectedItems.remove(item);
                                      }
                                      innerState(() {

                                      });
                                    },
                                  ))
                                      .toList(),
                                ),
                              ),
                              SizedBox(height: 20,),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, _selectedItems);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: size.height * 0.05,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,

                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.poppins(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,)
                            ],
                          )),
                    ),
                  ],
                );
              }
          );
        });

    /*final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );*/

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
        print(_selectedItems);
        //langaugeTextEditingController.clear();
        /*results.forEach((element) {
          langaugeTextEditingController.text = element+","+langaugeTextEditingController.text;
        });
        if (langaugeTextEditingController.text != null && langaugeTextEditingController.text.length > 0) {
          langaugeTextEditingController.text = langaugeTextEditingController.text.substring(0, langaugeTextEditingController.text.length - 1);
        }*/
      });
    }
  }

  void _showGenderMultiSelect() async {

    _selectedGenders = [];
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = sexualIdentityPreferences;



    final List<String>? results = await showModalBottomSheet(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0),
              topLeft: Radius.circular(50.0),
            )),
        context: context,
        builder: (context) {

          var size = MediaQuery.of(context).size;

          return StatefulBuilder(
              builder: (context,innerState) {
                return Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Select Gender Preferences",
                                  style: GoogleFonts.raleway(
                                      textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SingleChildScrollView(
                                child: ListBody(
                                  children: items
                                      .map((item) => CheckboxListTile(
                                    activeColor: primaryColorOfApp,
                                    value: _selectedGenders.contains(item),
                                    title: Text(item),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    onChanged: (isChecked) {
                                      if(isChecked!){
                                        if(!_selectedGenders.contains(item)){
                                          _selectedGenders.add(item);
                                        }
                                      }
                                      else{
                                        _selectedGenders.remove(item);
                                      }
                                      innerState(() {

                                      });
                                    },
                                  ))
                                      .toList(),
                                ),
                              ),
                              SizedBox(height: 20,),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, _selectedGenders);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: size.height * 0.05,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,

                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.poppins(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,)
                            ],
                          )),
                    ),
                  ],
                );
              }
          );
        });

    /*final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );*/

    // Update UI
    if (results != null) {
      setState(() {
        _selectedGenders = results;
        print(_selectedGenders);
        //langaugeTextEditingController.clear();
        /*results.forEach((element) {
          langaugeTextEditingController.text = element+","+langaugeTextEditingController.text;
        });
        if (langaugeTextEditingController.text != null && langaugeTextEditingController.text.length > 0) {
          langaugeTextEditingController.text = langaugeTextEditingController.text.substring(0, langaugeTextEditingController.text.length - 1);
        }*/
      });
    }
  }
}
