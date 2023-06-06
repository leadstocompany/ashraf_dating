import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration3Screen.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration7Screen.dart';
import 'package:fluid_dating_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Helper/reusable_widgets.dart';
import '../../home_screen_tabs/profile_editing_screens/EditProfileScreen.dart';
import 'BioAndInterestScreen.dart';

class FilterByScreenForRegistration extends StatefulWidget {
  const FilterByScreenForRegistration({Key? key}) : super(key: key);

  @override
  State<FilterByScreenForRegistration> createState() => _FilterByScreenForRegistrationState();
}

class _FilterByScreenForRegistrationState extends State<FilterByScreenForRegistration> {
  TextEditingController bioTextEditingController = TextEditingController();
  TextEditingController dreamsTextEditingController = TextEditingController();

  RangeValues distanceRangeValues = const RangeValues(0, 70);
  RangeValues ageRangeValues = const RangeValues(18, 60);

  List<String> _selectedItems = [];
  List<String> _selectedGenders = [];

  TextEditingController sexualIdentityPreferenceTextEditingController  = TextEditingController();

  List<String> relationShipGoals = [
    "Casual",
    "Long term",
    "Looking for Marriage"
  ];

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



  String? relationShipGoal;
  String? genderPreference;
  String? sexualIdentityPreference;

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
              ReusableWidgets().FluidHeaderText("Filter By",context),
              SizedBox(height: size.height*0.05,),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ReusableWidgets().FluidDropDown(
                        context,
                        "Relationship goal","Please Select...",relationShipGoals,(val){
                      relationShipGoal = val;
                      setState(() {

                      });
                    },relationShipGoal
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Choose One",style:Theme.of(context).textTheme.titleSmall,),
                    ),
                    SizedBox(height: size.height*0.04,),
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
                    ReusableWidgets().FluidTextField("", "", context, sexualIdentityPreferenceTextEditingController,false,false,null,false,Icon(Icons.add_circle_outline,color: primaryColorOfApp,),null,(){_showMultiSelect();},),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Choose Multiple",style:Theme.of(context).textTheme.titleSmall,),
                    ),
                    SizedBox(height: size.height*0.04,),
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

                    ReusableWidgets().FluidTextField("", "", context, sexualIdentityPreferenceTextEditingController,false,false,null,false,Icon(Icons.add_circle_outline,color: primaryColorOfApp,),null,(){_showGenderMultiSelect();},),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Choose Multiple",style:Theme.of(context).textTheme.titleSmall,),
                    ),
                    SizedBox(height: size.height*0.06,),
                    Text("Age",style:Theme.of(context).textTheme.titleMedium,),
                    RangeSlider(
                      values: ageRangeValues,
                      min: 0,
                      max: 100,
                      activeColor: Colors.purple,
                      inactiveColor: Colors.purple.shade100,
                      divisions: 10,
                      labels: RangeLabels(
                        ageRangeValues.start.round().toString(),
                        ageRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          ageRangeValues = values;
                        });
                      },
                    ),
                    SizedBox(height: size.height*0.06,),
                    Text("Distance",style:Theme.of(context).textTheme.titleMedium,),
                    RangeSlider(
                      values: distanceRangeValues,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      activeColor: Colors.indigo,
                      inactiveColor: Colors.indigo.shade100,
                      labels: RangeLabels(
                        distanceRangeValues.start.round().toString(),
                        distanceRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          distanceRangeValues = values;
                        });
                      },
                    ),
                    SizedBox(height: size.height*0.05,),
                    ReusableWidgets().FluidButton("NEXT", (){
                      Get.to(BioAndInterestScreen());
                    }, context),
                    SizedBox(height: size.height*0.05,),
                  ],
                ),
              )
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
