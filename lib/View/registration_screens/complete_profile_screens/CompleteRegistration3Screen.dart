import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluid_dating_app/Helper/app_helper.dart';
import 'package:fluid_dating_app/Helper/reusable_widgets.dart';
import 'package:fluid_dating_app/Network/api_repository.dart';
import 'package:fluid_dating_app/View/home_screen_tabs/profile_editing_screens/EditProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import 'CompleteRegistration4Screen.dart';

class CompleteRegistration3Screen extends StatefulWidget {
  const CompleteRegistration3Screen({Key? key}) : super(key: key);

  @override
  State<CompleteRegistration3Screen> createState() => _CompleteRegistration3ScreenState();
}

class _CompleteRegistration3ScreenState extends State<CompleteRegistration3Screen> {

  List<File?> listOfUploadedImages = [File('file. txt'),File('file. txt'),File('file. txt'),File('file. txt'),File('file. txt'),File('file. txt')];

  List<String> uploadedToBackendImageUrls = ["","","","","",""];

  int? uploadingPhotoNumber;
  final ImagePicker imagePicker = ImagePicker();

  String? localProfileImageUrl;
  File? backgroundImageFile;

  UploadTask? task;


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
              SizedBox(height: size.height*0.06,),

              ReusableWidgets().FluidHeaderText("Add Your Photos",context),
              ReusableWidgets().FluidNoteText("Add multiple photos to get a higher number of daily matches.", context),
              SizedBox(height: size.height*0.01,),
              PhotoAlbumGrid(),
              ReusableWidgets().FluidButton("NEXT", (){


                Get.to(CompleteRegistration4Screen());


              }, context),
              SizedBox(height: size.height*0.04,),

            ],
          ),
        ),
      ),
    );



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
    String? profileId = "profileName";

    destinationForImage = id+'/$profileId/'+(uploadingPhotoNumber.toString()??"ERROR");


    task = ApiRepository.uploadFile(destinationForImage, file!);
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

    List<String> gallery = uploadedToBackendImageUrls;

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
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
        
        child: ReorderableGridView.builder(

          onReorder: _onReorder,
          physics: NeverScrollableScrollPhysics(),

          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 160,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemBuilder: (c, i) {
            print("Buildeing");


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
                              Icons.close, color: Theme.of(context).primaryColor,),
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
      ),
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
                  CircleAvatar(child: Icon(Icons.add,color: Theme.of(context).primaryColor==Colors.white?Theme.of(context).primaryColor:Colors.white,),radius: 15,backgroundColor: Theme.of(context).primaryColor,),
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
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
      ),
    );
  }
}
