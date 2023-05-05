import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  List<int> list = List<int>.generate(500, (i) => i + 1);

  TextEditingController messageTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
        margin: EdgeInsets.only(bottom: 20,top: 15),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              margin: EdgeInsets.only(right: size.width*0.02),
              child: Icon(Icons.add),decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),),
            Expanded(child: TextField(
             
              controller: messageTextEditingController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                fillColor: Theme.of(context).primaryColor,
                suffixIconColor: Theme.of(context).primaryColor,
                suffixIcon: IconButton(onPressed: (){},
                    icon: Icon(Icons.send)),
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
            )),
            Container(
              width: 55,
              height: 55,
              margin: EdgeInsets.only(left: size.width*0.02),
              child: Icon(Icons.mic,color: Color(0xff8681E9),),decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),),

          ],
        ),
      ),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),

        child:Container(
          width: size.width,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(width: 10,),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 30,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("https://flxt.tmsimg.com/assets/283805_v9_ba.jpg"),
                        radius: 26,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableWidgets().FluidBoldSubHeaderText("Jaaneman", context,false),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.circle,color: Colors.green,size: 10,),
                            ReusableWidgets().FluidParagraphText("Online", context),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 55,
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: size.width*0.02,
                      vertical:size.width*0.02 ),
                  child: Icon(Icons.more_vert_rounded,color: Colors.grey,),decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),),
              )
            ],
          ),
        )

        /*child: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.green,
          actions: [
            Container(
              width: 55,
              height: 55,
              margin: EdgeInsets.symmetric(horizontal: size.width*0.02,
              vertical:size.width*0.02 ),
              child: Icon(Icons.more_vert_rounded,color: Colors.grey,),decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),)
          ],
          elevation: 0,
          title: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://flxt.tmsimg.com/assets/283805_v9_ba.jpg"),
                    radius: 26,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableWidgets().FluidBoldSubHeaderText("Jaaneman", context,false),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.circle,color: Colors.green,size: 10,),
                        ReusableWidgets().FluidParagraphText("Online", context),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),*/
      ),
      body: ListView.builder(itemBuilder: (c,i){

        if(i%2==0){
          return RecieverMessages();
        }
        else{
          return SenderMessages();
        }
      },itemCount: list.length,),
    );
  }

  Widget SenderMessages() {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: size.width*0.05,right:size.width*0.2 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFFFADED),
              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
            ),
            child: Text("Aey! Main teko keech ke maar dungi haan ! Udhar ich Mar jayenga!😡😡😡😡😡\nTeko Malum Kya Mera Baap kon hai ...."),),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("2:55 PM",style: TextStyle(fontSize: 13,color: Colors.grey),),
            ],
          )
        ],
      ),
    );
  }

  Widget RecieverMessages() {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: size.width*0.2,right:size.width*0.05 ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xffF3F3F3),
              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
            ),
            child: Text("Kya bol re li Jaaneman , Jaane Bahar ....🍆"),),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("2:55 PM",style: TextStyle(fontSize: 13,color: Colors.grey),),
              SizedBox(width: 2,),
              Icon(Icons.done_all,size:15,color:Theme.of(context).primaryColor ,)
            ],
          )
        ],
      ),
    );
  }
}
