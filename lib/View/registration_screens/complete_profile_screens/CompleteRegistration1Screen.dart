import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration2Screen.dart';
import 'package:fluid_dating_app/globals.dart';
import 'package:flutter/material.dart';
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

  var a;


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableWidgets().FluidHeaderText("Create your Profile",context),
              ReusableWidgets().FluidTextField("Name", "Username...", context, nameTextEditingController,false,true,null,false),
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
                  ReusableWidgets().FluidTextField("Language", "Languages..", context, langaugeTextEditingController,false,true,null,false),
                  ReusableWidgets().FluidTextField("Location", "Location..", context, locationTextEditingController,false,true,null,false,),
                  ReusableWidgets().FluidButton("NEXT", (){


                    Get.to(CompleteRegistration2Screen());


                  }, context),

            ],
          ),
        ),
      ),
    );
  }
}
