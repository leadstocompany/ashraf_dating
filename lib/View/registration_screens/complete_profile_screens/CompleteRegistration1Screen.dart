import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration2Screen.dart';
import 'package:fluid_dating_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
///import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:intl/intl.dart';

class CompleteRegistration1Screen extends StatefulWidget {
  const CompleteRegistration1Screen({Key? key}) : super(key: key);

  @override
  State<CompleteRegistration1Screen> createState() => _CompleteRegistration1ScreenState();
}

class _CompleteRegistration1ScreenState extends State<CompleteRegistration1Screen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();
  TextEditingController langaugeTextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();

  String? bdayErrorText;

  String? _currentAddress;
  Position? _currentPosition;

  var a;

  Future<void> _getCurrentPosition() async {
    print("Ashraf");
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
          _currentPosition = position;
           _getAddressFromLatLng(_currentPosition!);
          setState(() {});

    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        locationTextEditingController.text = _currentAddress.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'English',
      'Hindi',
      'Marathi',
      'Gujrati',
      'Hungarian',
      'Italian',
      'Indonesian'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
        print(_selectedItems);
        langaugeTextEditingController.clear();
        results.forEach((element) {
          langaugeTextEditingController.text = element+","+langaugeTextEditingController.text;
        });
        if (langaugeTextEditingController.text != null && langaugeTextEditingController.text.length > 0) {
          langaugeTextEditingController.text = langaugeTextEditingController.text.substring(0, langaugeTextEditingController.text.length - 1);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;



    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.1,),
                ReusableWidgets().FluidHeaderText("Create your Profile",context),
                SizedBox(height: size.height*0.1,),
                ReusableWidgets().FluidTextField("Name", "Username...", context, nameTextEditingController,false,true,null,false),
                SizedBox(height: size.height*0.025,),
                GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50.0),
                                topLeft: Radius.circular(50.0),
                              )),
                          context: context,
                          builder: (context) {
                            return Container(
                              height: size.height * 0.6,
                              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                              child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Start Date",
                                          style: GoogleFonts.raleway(
                                              textStyle:
                                              Theme.of(context).textTheme.titleLarge,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      SfDateRangePicker(
                                        selectionMode: DateRangePickerSelectionMode.single,
                                        view: DateRangePickerView.decade,
                                        rangeSelectionColor:
                                        Theme.of(context).primaryColor.withOpacity(0.3),
                                        startRangeSelectionColor: Theme.of(context).primaryColor,
                                        endRangeSelectionColor: Theme.of(context).primaryColor,
                                        selectionColor: Theme.of(context).primaryColor,
                                        maxDate: DateTime.now(),
                                        /*maxDate: DateTime(DateTime.now().year - 12,
                                        DateTime.now().month, DateTime.now().day),
                                        minDate: DateTime(DateTime.now().year - 150,
                                        DateTime.now().month, DateTime.now().day),*/
                                        todayHighlightColor: Colors.black,
                                        headerHeight: 50,
                                        showNavigationArrow: true,
                                        onSelectionChanged: (ob) {
                                          print(ob.value);
                                          String formattedDate =
                                          DateFormat('yyyy-MM-dd').format(ob.value);
                                          a = Jiffy(formattedDate).yMMMMd;
                                        },
                                        onSubmit: (ob) {
                                          print(ob.runtimeType);
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          dobTextEditingController.text = a;
                                          bdayErrorText = null;
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          height: size.height * 0.09,
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
                                    ],
                                  )),
                            );
                          });
                    },
                    child: ReusableWidgets().FluidTextField("Date of Birth", "DD/MM/YYYY", context, dobTextEditingController,false,true,null,true,Icon(Icons.date_range,color: primaryColorOfApp,))),
                SizedBox(height: size.height*0.025,),
                /*Wrap(
                  children: _selectedItems
                      .map((e) => Chip(
                    backgroundColor: primaryColorOfApp,
                    label: Text(e,style: TextStyle(color: Colors.white,fontSize: 12),),
                  ))
                      .toList(),
                ),*/
                ReusableWidgets().FluidTextField("Language", "Languages..", context, langaugeTextEditingController,false,false,null,false,null,null,(){_showMultiSelect();}),
                // display selected items

                SizedBox(height: size.height*0.025,),
                Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Location"),
                            Text(false?"*":"",style: TextStyle(color: Colors.red),),
                          ],
                        ),
                        SizedBox(height: "Location"==""?0:8,),
                        TextField(

                          controller: locationTextEditingController,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).primaryColor,
                            prefixIconColor: Theme.of(context).primaryColor,

                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: IconButton(onPressed: (){
                              _getCurrentPosition();
                            },
                                icon: Icon(Icons.my_location,color: primaryColorOfApp,)),
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                                borderSide:  BorderSide(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            disabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                                borderSide:  BorderSide(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            focusedBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                                borderSide:  BorderSide(color: Theme.of(context).primaryColor, width: 1),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                                borderSide:  BorderSide(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ],
                    ),
                SizedBox(height: size.height*0.1,),
                ReusableWidgets().FluidButton("NEXT", (){
                      Get.to(CompleteRegistration2Screen());
                    }, context),

              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

}
