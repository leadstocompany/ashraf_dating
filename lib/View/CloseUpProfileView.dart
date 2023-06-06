import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/reusable_widgets.dart';
import '../globals.dart';
import 'home_screen_tabs/HomeScreen.dart';
import 'home_screen_tabs/profile_editing_screens/EditProfileScreen.dart';

class CloseUpProfileView extends StatefulWidget {
  ProfileModal? subProfileModal;
  CloseUpProfileView({Key? key,this.subProfileModal,}) : super(key: key);

  @override
  State<CloseUpProfileView> createState() => _CloseUpProfileViewState();
}

class _CloseUpProfileViewState extends State<CloseUpProfileView> {
  TextEditingController aboutTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
            floating: false,
            pinned: true,
            //backgroundColor: Colors.transparent,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100))),
            expandedHeight: 550.0,
            collapsedHeight: 60,
            actions: [
              Icon(Icons.verified_user_rounded,size:40,color: Colors.blue,),
              IconButton(onPressed: (){
                _showOptionsActionSheet(context);
              }, icon: Icon(Icons.more_horiz,color: Colors.white,))
            ],
            title:CircleAvatar(backgroundImage: NetworkImage(widget.subProfileModal?.profileImage??"https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg"),radius: 25,),

            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.subProfileModal?.name??"Ashraf Khan M , 23", textScaleFactor: 1),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.subProfileModal?.profileImage??"https://i.ibb.co/D7jVpXK/343546054-784306129709024-5849246366806181903-n.jpg"),
                  ),
                  borderRadius:BorderRadius.only(
                    bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))
                ),

              ),
            ),
          ),
          //3
          SliverList(
            delegate: SliverChildListDelegate(
              [

                Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.05),
                  child: ReusableWidgets().FluidBoldHeaderText("Gender", context, false),),

                Padding(padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Wrap(
                    spacing: 10,
                    direction: Axis.horizontal,
                    children: genderChoiceChips(),
                  ),
                ),

                SizedBox(height: size.height*0.02,),
                Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.05),
                  child: ReusableWidgets().FluidBoldHeaderText("Sexuality", context, false),),

                Padding(padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Wrap(
                    spacing: 10,
                    direction: Axis.horizontal,
                    children: genderChoiceChips(),
                  ),
                ),

                SizedBox(height: size.height*0.02,),
                Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.05),
                  child: ReusableWidgets().FluidBoldHeaderText("About", context, false),),


                Padding(padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: ReusableWidgets().FluidTextField("", "", context, aboutTextEditingController, false, false, () => null, false,null,7),
                ),


                SizedBox(height: size.height*0.02,),
                Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.05),
                  child: ReusableWidgets().FluidBoldHeaderText("Intrested in", context, false),),

                Padding(padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Wrap(
                    spacing: 10,
                    direction: Axis.horizontal,
                    children: choiceChips(),
                  ),
                ),

                SizedBox(height: size.height*0.02,),
                Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.05),
                  child: ReusableWidgets().FluidBoldHeaderText("Dream", context, false),),

                Padding(padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: ReusableWidgets().FluidTextField("", "", context, aboutTextEditingController, false, false, () => null, false,null,7),
                ),

                SizedBox(height: size.height*0.02,),
                Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.05),
                  child: ReusableWidgets().FluidBoldHeaderText("Photos", context, false),),

                Padding(padding: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.05),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      crossAxisCount: 3,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      // Item rendering
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          "https://pbs.twimg.com/profile_images/1282931979365740544/DRoTbhEp_400x400.jpg",
                        ),
                      );
                    },
                  ),
                ),

              ]
            ),
          ),
        ],
      ),
    );
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

  List<Widget> choiceChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ChoiceChip(
          label: Text(_choiceChipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          shape: StadiumBorder(side: BorderSide(color: customSelectionColorOfApp)),
          //backgroundColor: _choiceChipsList[i].color,
          backgroundColor: customSelectionColorOfApp,
          selected: true,
          selectedColor: customSelectionColorOfApp,
          onSelected: (bool value) {

          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }









  final List<Data> _genderList = [
    Data("Male", Colors.green),
    Data("Female", Colors.blue),
    Data("Transgender", Colors.deepOrange),
  ];

  List<String> genderselectedIntrests = [];

  int? _genderselectedIndex;

  List<Widget> genderChoiceChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _genderList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ChoiceChip(
          label: Text(_genderList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          shape: StadiumBorder(side: BorderSide(color: customSelectionColorOfApp)),
          //backgroundColor: _choiceChipsList[i].color,
          backgroundColor: customSelectionColorOfApp,
          selected: true,
          selectedColor: customSelectionColorOfApp,
          onSelected: (bool value) {

          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  void _showOptionsActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(

        // message: const Text('Select an action for the selected user'),
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
            child:Text('Report User'),
          ),
          CupertinoActionSheetAction(

            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            onPressed: () {
              Navigator.pop(context);
            },
            child:Text('Match User'),
          ),

          /*CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),*/
        ],
      ),
    );
  }








}
