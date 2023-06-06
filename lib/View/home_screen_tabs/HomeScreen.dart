import 'dart:developer';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:fluid_dating_app/View/CloseUpProfileView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitleValueNotifier{
  ValueNotifier valueNotifier = ValueNotifier("Wings");

  void changeTitle(String newTitle){
    valueNotifier.value = newTitle;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AppinioSwiperController controller = AppinioSwiperController();
  AppTitleValueNotifier appValueNotifier = AppTitleValueNotifier();

  List<ProfileCard> cards = [
    ProfileCard(subProfileModal:ProfileModal(name: "Ashraf",gender: "Male",age: 23,profileImage: "https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg")),
    ProfileCard(subProfileModal:ProfileModal(name: "Papi Chulo",gender: "Male",age: 23,profileImage: "https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg")),
    ProfileCard(subProfileModal:ProfileModal(name: "Chota Kasim",gender: "Male",age: 23,profileImage: "https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg")),
    ProfileCard(subProfileModal:ProfileModal(name: "Diana Kovacs",gender: "Female",age: 19,profileImage: "https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg")),
    ProfileCard(subProfileModal:ProfileModal(name: "Anna",gender: "Female",age: 23,profileImage: "https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg")),
    ProfileCard(subProfileModal:ProfileModal(name: "Rasmalai",gender: "Female",age: 23,profileImage: "https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg")),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          /*appBar: AppBar(
            title : ValueListenableBuilder(
              valueListenable: appValueNotifier.valueNotifier,
              builder: (context, value, child) {
                return Text("@"+value.toString(),style: GoogleFonts.raleway(
                    textStyle: Theme.of(context).textTheme.headline6,
                    color: Theme.of(context).primaryColor));
              },
            ),

            actions: [
              unswipeButton(controller,context),
            ],

            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor, //change your color here
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
          ),*/
          body:Container(
            padding: EdgeInsets.only(top: 20),
            child: AppinioSwiper(
              unlimitedUnswipe: true,
              controller: controller,
              unswipe: _unswipe,
              cardsCount: cards.length,
              cardsBuilder: (BuildContext context,int index){
                return cards[index];
              },
              onSwipe: _swipe,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 0,
                bottom: 0,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () => controller.swipeLeft(),
                        child: Icon(Icons.heart_broken,size:40,color: Theme.of(context).primaryColor,),
                      ),
                    ),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () => controller.swipeRight(),
                        child: Icon(Icons.star,size: 40,color:Color(0xffFFADED),),
                      ),
                    ),
                  ),
                  Container(
                    height: 75.0,
                    width: 75.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () => controller.swipeRight(),
                        child: Icon(Icons.favorite,size: 40,color: Colors.red,)
                      ),
                    ),
                  ),
                ]
            ),
          )
      ),
    );
  }

  void _swipe(int index, AppinioSwiperDirection direction) {
    log("the card was swiped to the: " + direction.name);
  }

  void _unswipe(bool unswiped) {
    if (unswiped) {
      log("SUCCESS: card was unswiped");
    } else {
      log("FAIL: no card left to unswipe");
    }
  }

  void _onEnd() {
    log("end reached!");
  }
}


class ExampleButton extends StatelessWidget {
  final Function onTap;
  final Widget child;

  const ExampleButton({
    required this.onTap,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: child,
    );
  }
}

//swipe card to the right side
Widget swipeRightButton(AppinioSwiperController controller) {
  return ExampleButton(
    onTap: () => controller.swipeRight(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: CupertinoColors.activeGreen,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.activeGreen.withOpacity(0.9),
            spreadRadius: -10,
            blurRadius: 20,
            offset: const Offset(0, 20), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.check,
        color: CupertinoColors.white,
        size: 40,
      ),
    ),
  );
}

//swipe card to the left side
Widget swipeLeftButton(AppinioSwiperController controller) {
  return ExampleButton(
    onTap: () => controller.swipeLeft(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFF3868),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF3868).withOpacity(0.9),
            spreadRadius: -10,
            blurRadius: 20,
            offset: const Offset(0, 20), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.close,
        color: CupertinoColors.white,
        size: 40,
      ),
    ),
  );
}

//unswipe card

//unswipe card
Widget unswipeButton(AppinioSwiperController controller,BuildContext context) {
  return ExampleButton(
    onTap: () => controller.unswipe(),
    child: Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      child:  Icon(
        Icons.rotate_left_rounded,
        color: Theme.of(context).primaryColor,
        size: 40,
      ),
    ),
  );
}

class ExampleCandidateModel {
  String? name;
  String? job;
  String? city;
  LinearGradient? color;

  ExampleCandidateModel({
    this.name,
    this.job,
    this.city,
    this.color,
  });
}

List<ExampleCandidateModel> candidates = [
  ExampleCandidateModel(
    name: 'Eight, 8',
    job: 'Manager',
    city: 'Town',
    color: gradientPink,
  ),
  ExampleCandidateModel(
    name: 'Seven, 7',
    job: 'Manager',
    city: 'Town',
    color: gradientBlue,
  ),
  ExampleCandidateModel(
    name: 'Six, 6',
    job: 'Manager',
    city: 'Town',
    color: gradientPurple,
  ),
  ExampleCandidateModel(
    name: 'Five, 5',
    job: 'Manager',
    city: 'Town',
    color: gradientRed,
  ),
  ExampleCandidateModel(
    name: 'Four, 4',
    job: 'Manager',
    city: 'Town',
    color: gradientPink,
  ),
  ExampleCandidateModel(
    name: 'Three, 3',
    job: 'Manager',
    city: 'Town',
    color: gradientBlue,
  ),
  ExampleCandidateModel(
    name: 'Two, 2',
    job: 'Manager',
    city: 'Town',
    color: gradientPurple,
  ),
  ExampleCandidateModel(
    name: 'One, 1',
    job: 'Manager',
    city: 'Town',
    color: gradientRed,
  ),
];

const LinearGradient gradientRed = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFF3868),
    Color(0xFFFFB49A),
  ],
);

const LinearGradient gradientPurple = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF736EFE),
    Color(0xFF62E4EC),
  ],
);

const LinearGradient gradientBlue = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF0BA4E0),
    Color(0xFFA9E4BD),
  ],
);

const LinearGradient gradientPink = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFF6864),
    Color(0xFFFFB92F),
  ],
);

const LinearGradient kNewFeedCardColorsIdentityGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF7960F1),
    Color(0xFFE1A5C9),
  ],
);

class ExampleCard extends StatelessWidget {
  final ExampleCandidateModel candidate;

  const ExampleCard({
    Key? key,
    required this.candidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CupertinoColors.white,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                gradient: candidate.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      candidate.job!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      candidate.city!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  ProfileModal? subProfileModal;
 // DocumentSnapshot? docSnapshot;


  ProfileCard({Key? key,this.subProfileModal,}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {

    String emoji = "😀";

    return InkWell(
      onTap: (){
        Get.to(CloseUpProfileView());
      },
      child: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: Stack(
                  children: [

                    Container(
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0.1, 0.8, 1],
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.subProfileModal?.profileImage??"https://flxt.tmsimg.com/assets/283805_v9_ba.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: CupertinoColors.black,
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.subProfileModal?.name??"Error",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Flexible(
                              child: Text(
                                (widget.subProfileModal?.gender.toString()??""+","+(widget.subProfileModal?.age.toString()??"")),
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          /*Text(
                                widget.subProfileModal.profileType!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              )*/
                        ],
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0,top: 8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Icon(Icons.verified_user_rounded,size:40,color: Theme.of(context).primaryColor,),
                              SizedBox(height: 10,),
                              IconButton(
                                onPressed: (){
                                  _showActionSheet(context,widget.subProfileModal?.name??"");
                                },
                                icon:Icon(Icons.more_horiz,color: Colors.white),)
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),

              /*Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Experience",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),

                  Timeline(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Intern Writer",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Text("Dharavi Daily Samachar",style: TextStyle(fontSize: 16),),
                          Text("3 Months",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sales & Counter Staff",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Text("Adult Sex Toy",style: TextStyle(fontSize: 16),),
                          Text("Currently Works Here",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],
                    indicators: <Widget>[
                      CircleAvatar(backgroundColor:Colors.black,child: Text("1",style: TextStyle(color: Colors.white),),),
                      CircleAvatar(backgroundColor:Colors.black,child: Text("2",style: TextStyle(color: Colors.white),),),

                    ],
                  ),*/
            ],
          ),
        ),
      ),
    );
  }

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context,String userName) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(

        title: Text(userName),
        message: const Text('Select an action for the selected user'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(

            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            onPressed: () {
              Navigator.pop(context);
            },
            child:Text('Block User'),
          ),
          CupertinoActionSheetAction(

            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            onPressed: () {
              Navigator.pop(context);
            },
            child:Text('Report User'),
          ),
          CupertinoActionSheetAction(

            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            onPressed: () {
              Navigator.pop(context);
            },
            child:Text('Like Photo'),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }


}

class ProfileModal {
  String? name;
  String? gender;
  int? age;
  String? profileImage;
  List? gallery;

  ProfileModal({
    this.name,
    this.gender,
    this.age,
    this.profileImage,
    this.gallery,
  });

}
