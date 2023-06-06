import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluid_dating_app/Helper/app_helper.dart';
import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/Network/api_repository_for_firebase.dart';
import 'package:fluid_dating_app/View/home_screen_tabs/HomeScreen.dart';
import 'package:fluid_dating_app/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid/reorderable_grid.dart';


class Data {
  String label;
  Color color;

  Data(this.label, this.color);
}


class EditProfileScreen extends StatefulWidget {
  final String profileName;

   EditProfileScreen({Key? key, required this.profileName}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController bioTextEditingController = TextEditingController();

  int? _selectedIndex;
  final List<Data> _choiceChipsList = [
    Data("Photography", Colors.green),
    Data("Music", Colors.blue),
    Data("Book", Colors.deepOrange),
    Data("Gaming", Colors.cyan),
    Data("Fashion", Colors.pink),
    Data("Architecture", Colors.pink),
  ];

  String? localProfileImageUrl;
  File? backgroundImageFile;

  String? relationShipGoal;
  String? genderPreference;
  String? sexualIdentityPreference;

  ProfileModal? profileModal;

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

  List<String> _selectedItems = [];
  List<String> _selectedGenders = [];

  TextEditingController sexualIdentityPreferenceTextEditingController  = TextEditingController();

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
                                    activeColor: customSelectionColorOfApp,
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
                                    color: customSelectionColorOfApp,

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
                                    activeColor: customSelectionColorOfApp,
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
                                    color: customSelectionColorOfApp,

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

  RangeValues distanceRangeValues = const RangeValues(0, 70);
  RangeValues ageRangeValues = const RangeValues(18, 60);

  double _value = 6;

  List<File?> listOfUploadedImages = [File('file. txt'),File('file. txt'),File('file. txt'),File('file. txt'),File('file. txt'),File('file. txt')];

  List<String> uploadedToBackendImageUrls = ["","","","","",""];

  int? uploadingPhotoNumber;
  final ImagePicker imagePicker = ImagePicker();

  UploadTask? task;
  
  List<String> selectedIntrests = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // relationShipGoal = _dropdownValues.first;
  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
        children: [
          PhotoAlbumGrid(),
          SizedBox(height: 10,),
          ReusableWidgets().FluidNoteText("Hold and Drag to adjust the order", context),
          SizedBox(height: 20,),
          ReusableWidgets().FluidBoldSubHeaderText("Add Bio", context, false),
          ReusableWidgets().FluidTextField("", "", context, bioTextEditingController, false, false, () => null, false,null,7),
          SizedBox(height: 40,),
          ReusableWidgets().FluidBoldSubHeaderText("Your interests", context, false),
          SizedBox(height: 0,),
          ReusableWidgets().FluidNoteText("You Can Select Multiple", context),
          SizedBox(height: 10,),
          Wrap(
            spacing: 10,
            direction: Axis.horizontal,
            children: choiceChips(),
          ),
          SizedBox(height: 40,),
          ReusableWidgets().FluidBoldSubHeaderText("Filter by :", context, false),
          SizedBox(height: 10,),
          ReusableWidgets().FluidDropDown(
            context,
              "Relationship goal","Please Select...",relationShipGoals,(val){
              relationShipGoal = val;
              setState(() {

              });
          },relationShipGoal
          ),
          SizedBox(height: 10,),
          Text("Sexual Identity Preferences"),
          Visibility(
              visible: _selectedItems.length>0,
              child: SizedBox(height: size.height*0.01,)),
          Wrap(
            children: _selectedItems
                .map((e) => Container(
              padding: EdgeInsets.only(right: 2),
              child: Chip(
                backgroundColor: customSelectionColorOfApp,
                label: Text(e,style: TextStyle(color: Colors.white,fontSize: 12),),
              ),
            ))
                .toList(),
          ),
          ReusableWidgets().FluidTextField("", "", context, sexualIdentityPreferenceTextEditingController,false,false,null,false,Icon(Icons.add_circle_outline,color: customSelectionColorOfApp,),null,(){_showMultiSelect();},),
          SizedBox(height: 10,),
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
                backgroundColor: customSelectionColorOfApp,
                label: Text(e,style: TextStyle(color: Colors.white,fontSize: 12),),
              ),
            ))
                .toList(),
          ),
          ReusableWidgets().FluidTextField("", "", context, sexualIdentityPreferenceTextEditingController,false,false,null,false,Icon(Icons.add_circle_outline,color: customSelectionColorOfApp,),null,(){_showGenderMultiSelect();},),
          SizedBox(height: 10,),
          Text("Age",style:Theme.of(context).textTheme.titleMedium,),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
            ),
            child: RangeSlider(
              values: ageRangeValues,
              min: 0,
              max: 100,
              activeColor: Colors.purple,
              inactiveColor: Colors.purple.shade100,
              divisions: 10,
              labels: RangeLabels(
                ageRangeValues.start.round().toString()+" Yrs",
                ageRangeValues.end.round().toString()+" Yrs",
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  ageRangeValues = values;
                });
              },
            ),
          ),
          SizedBox(height: 10,),
          Text("Distance",style:Theme.of(context).textTheme.titleMedium,),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
            ),
            child: RangeSlider(
              values: distanceRangeValues,
              min: 0,
              max: 100,
              divisions: 10,
              activeColor: Colors.indigo,
              inactiveColor: Colors.indigo.shade100,
              labels: RangeLabels(
                distanceRangeValues.start.round().toString()+" KM",
                distanceRangeValues.end.round().toString()+" KM",
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  distanceRangeValues = values;
                });
              },
            ),
          )

        ],
      )
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
          shape: StadiumBorder(side: BorderSide(color: customSelectionColorOfApp)),
          //backgroundColor: _choiceChipsList[i].color,
          backgroundColor: Colors.white,
          selected: selectedIntrests.contains(_choiceChipsList[i].label),
          selectedColor: customSelectionColorOfApp,
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

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = uploadedToBackendImageUrls.removeAt(oldIndex);
      uploadedToBackendImageUrls.insert(newIndex, item);
      localProfileImageUrl = uploadedToBackendImageUrls[0];
    });
  }

  pickImageForGridView(ImageSource imageSource,String fileName,int index) async {
    print("asasa(*)*()(");
    imagePicker
        .pickImage(
      source: imageSource,
    )
        .then((XFile? pickedXFile) {
      if (pickedXFile != null) {
        testCompressAndGetFileForGridView(pickedXFile,fileName,index);
      }
    }).catchError((e) {
      print("Error while uploading image: $e");
    });
  }

  Future<void> testCompressAndGetFileForGridView(XFile xfile,String fileName,index) async {
    File fixedFile = await AppHelper.fixHorizontalFlip(xfile, false);
    File compressedFile = await AppHelper.compressImage(fixedFile, 88);
    backgroundImageFile = compressedFile;
    listOfUploadedImages[int.parse(fileName)]=backgroundImageFile;
    print("fileName");
    print(fileName);
    uploadFile(backgroundImageFile!,fileName,index);
  }

  Future uploadFile(file,fileName,index) async {
    if (file == null) return;

    //final fileName = basename(file!.path);
    String destinationForImage="Fuzzy";


    String id = FirebaseAuth.instance.currentUser!.uid;
    String? profileId = widget!.profileName;

    destinationForImage = id+'/$profileId/'+(uploadingPhotoNumber.toString()??"ERROR");


    task = FirebaseApiRepository.uploadFile(destinationForImage, file!);
    uploadingPhotoNumber = index;
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();


    print('Download-Link: $urlDownload');

    uploadedToBackendImageUrls[int.parse(fileName)]=urlDownload;
    print(uploadedToBackendImageUrls.toList());
    print(listOfUploadedImages.toList());

    uploadingPhotoNumber = null;

    if(index==0){
      localProfileImageUrl  = urlDownload;
    }

    profileModal?.gallery = uploadedToBackendImageUrls;

    setState(() {

    });


    print("Now Let's Have a Name");

    //final CollectionReference postsRef = FirebaseFirestore.instance.collection('/comicBooks');

    //await postsRef.doc().set({"comicName":comicNameTextEditingController.text,"comicDesc":comicDescTextEditingController.text,"coverURL":urlDownload2,"comicPDFURL":urlDownload});

    print("files/$fileName" + "Files Added Successfully");

    ///Have a local File array
    ///Firstly get all the files if any
    ///Upload the whole array on reorder
    ///On Every re-order , reupload Images
    ///On every upload upload whole array

    setState(() {

    });

  }

  PhotoAlbumGrid() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      //height: 360,
      child: ReorderableGridView.builder(
        onReorder: _onReorder,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemBuilder: (c, i) {
          return Container(
              key: ValueKey(i),
              child: uploadedToBackendImageUrls[i] != "" ?
              Stack(
                children: [
                  Container(
                    // margin: const EdgeInsets.only(left: 0.0,bottom: 0,top:15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: uploadedToBackendImageUrls[i] !=
                              "Unpublished" ? NetworkImage(
                              uploadedToBackendImageUrls[i]) : AssetImage(
                              'assets/wingsUnpublished.png') as ImageProvider,
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      color: CupertinoColors.black,
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withOpacity(
                              0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                  InkWell(

                    child: Container(
                      child: Align(
                        child: CircleAvatar(
                          radius: 15,
                          child: Icon(
                            Icons.close, color: customSelectionColorOfApp,),
                          backgroundColor: Colors.white,
                        ),
                        alignment: Alignment.topRight,
                      ),
                    ), onTap: () {
                    uploadedToBackendImageUrls[i] = "";
                    if (i == 0) {
                      localProfileImageUrl = null;
                    }
                    setState(() {

                    });
                  },
                  ),
                ],
              ) : MiniPhotoWidget(i)
          );
        },
        itemCount: 6,),
    );
  }

  MiniPhotoWidget(int index) {
    return uploadingPhotoNumber!=index?InkWell(
      onTap:(){
        uploadingPhotoNumber = index;
        pickImageForGridView(ImageSource.gallery,index.toString(),index);
      },
      child: Container(
        padding: EdgeInsets.only(top: 2,bottom: 2),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          padding: EdgeInsets.all(6),
          color: Colors.grey,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(child: Icon(Icons.add,color: customSelectionColorOfApp==Colors.white?customSelectionColorOfApp:Colors.white,),radius: 15,backgroundColor: customSelectionColorOfApp,),
                  SizedBox(height: 10,),
                  Text("Tap to add\nnew image",style: TextStyle(color: Colors.grey,)),
                ],
              ),
            ),
          ),
        ),
      ),
    ):ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 10,
        width: 10,
        child: CircularProgressIndicator(color: customSelectionColorOfApp,),
      ),
    );
  }
}
