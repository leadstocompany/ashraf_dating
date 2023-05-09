import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_dating_app/Helper/app_helper.dart';
import 'package:fluid_dating_app/Helper/progress_dialog.dart';
import 'package:fluid_dating_app/Network/api_repository.dart';
import 'package:fluid_dating_app/View/registration_screens/complete_profile_screens/CompleteRegistration6Screen.dart';
import 'package:fluid_dating_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';


class CompleteRegistration5Screen extends StatefulWidget {
  final String profileName;


  const CompleteRegistration5Screen({Key? key, required this.profileName}) : super(key: key);

  @override
  State<CompleteRegistration5Screen> createState() => _CompleteRegistration5ScreenState();
}

class _CompleteRegistration5ScreenState extends State<CompleteRegistration5Screen> {

  late CameraController controller;


  String selectedVideoPromptMessage = "";

  late Future<List<String>> myPromptsList;

  XFile? imageFile;
  XFile? videoFile;
  VideoPlayerController? videoController;

  VoidCallback? videoPlayerListener;

  @override
  void dispose() {
    controller.dispose();
    videoController?.dispose();
    super.dispose();
  }

  bool isRecordingVideo = false;

  @override
  void initState() {
    super.initState();
    initCamera(0);
    myPromptsList = getVideoPromptQuestions();
  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return SafeArea(
      child: Material(
        child: videoFile==null?FutureBuilder<List<String>>(
            future: myPromptsList,
            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went  wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppHelper().LaodingPleaseWaitWidget("Please Wait",context);
              }


              List<String>? promptQuestions = snapshot.data;

              return Stack(
                  children: <Widget>[
                    Container(
                        height: size.height,
                        width: size.width,
                        child: CameraPreview(controller)),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0,left: 30,right: 30),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(!controller.value.isRecordingVideo?"":"Recording....",style: TextStyle(color: Colors.black),),
                              InkWell(
                                onTap: () async {
                                  if(controller.value.isRecordingVideo){
                                    return;
                                  }
                                  ///Open a Prompt Modal Bottom Sheet Maybe
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                      ),
                                      builder: (BuildContext context) {


                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text("Select a prompt question",style : Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),),
                                            ),
                                            Flexible(
                                              child: ListView.builder(
                                                  itemCount: promptQuestions!.length,
                                                  itemBuilder: (c,i){

                                                    return ListTile(
                                                      title: Text(promptQuestions[i]),
                                                      onTap: () {
                                                        print(promptQuestions[i]);
                                                        selectedVideoPromptMessage = promptQuestions[i];
                                                        Navigator.pop(context);
                                                        setState(() {

                                                        });
                                                      },
                                                    );
                                                  }),
                                            ),
                                          ],
                                        );
                                        // return your layout
                                      });
                                  ///

                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20,top: 10),
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(!controller.value.isRecordingVideo?selectedVideoPromptMessage:"Press to stop recording",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(radius:30,backgroundColor:Colors.black.withOpacity(0.5),child: Icon(Icons.image,size: 30,color: Colors.white,)),


                                  InkWell(
                                    onTap: (){

                                      if(!controller.value.isRecordingVideo){
                                        onVideoRecordButtonPressed();
                                      }
                                      else{
                                        onStopButtonPressed();
                                      }

                                      setState(() {

                                      });


                                    },
                                    child:!controller.value.isRecordingVideo? CircleAvatar(radius: 45,backgroundColor: Theme.of(context).primaryColor,child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 35,
                                    ),):Container(
                                      height: 70,
                                      width: 70,
                                      padding: EdgeInsets.all(20),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.red,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(

                                      onTap: (){
                                        if(controller.cameraId==0){
                                          initCamera(1);
                                        }
                                        else{
                                          initCamera(0);
                                        }
                                        setState(() {

                                        });
                                      },
                                      child: CircleAvatar(radius:30,backgroundColor:Colors.black.withOpacity(0.5),child: Icon(Icons.camera_front,size: 30,color: Colors.white,))),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]);
            }):Scaffold(
          //Done Button

          body: Stack(

            children: [

              Container(
                height: MediaQuery.of(context).size.height*0.87,
                width: MediaQuery.of(context).size.width,
                child: VideoPlayer(
                    videoController!),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text(selectedVideoPromptMessage,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0,bottom: 20),
                  child: InkWell(
                    onTap: () async {
                      // when clicked on floating action button prompt to create user
                      //Save Video Prompt to Backend
                      ProgressDialog.show(context, "Uploading Video Prompt");

                    /*  String destination= "VideoPrompt/"+selectedVideoPromptMessage;
                      String videoPromptDownloadUrl = await ApiRepository.uploadFileAndGetDownloadUrl(destination,File(videoFile!.path));*/

                      /*ProfileModal myNewProfileModal = widget.profileModal;

                      for(int i = 0;i<myNewProfileModal.videoPrompts!.length;i++){

                        if(myNewProfileModal.videoPrompts==""){
                          myNewProfileModal.videoPrompts?.add({selectedVideoPromptMessage:videoPromptDownloadUrl});
                        }
                        if(myNewProfileModal.videoPrompts==null){
                          myNewProfileModal.videoPrompts?.add({selectedVideoPromptMessage:videoPromptDownloadUrl});
                        }

                      }
                      myNewProfileModal.videoPrompts!.add({selectedVideoPromptMessage:videoPromptDownloadUrl});
                      print(myNewProfileModal.toJson());
                      print(myNewProfileModal.videoPrompts.toString());
                      await ApiRepository().updateProfileDetails(myNewProfileModal);*/
                      ProgressDialog.hide();
                      videoController?.dispose();
                      Get.to(CompleteRegistration6Screen());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: size.height * 0.09,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                            'Save & Upload Video',
                            style:Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight:FontWeight.bold,color: Colors.white)
                        ),
                      ),
                    ),
                  ),
                ),
              )
              //Prompt As a Title
            ],
          ),
        ),
      ),
    );
  }

  // #docregion AppLifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      //onNewCameraSelected(cameraController.description);
    }
  }

  void initCamera(int index) {
    controller = CameraController(cameras[index], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
      ///Save Recording here

    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((XFile? file) {
      if (mounted) {
        setState(() {});
      }
      if (file != null) {
        // showInSnackBar('Video recorded to ${file.path}');
        videoFile = file;
        _startVideoPlayer();
      }
    });
  }

  Future<void> pauseVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> _startVideoPlayer() async {
    if (videoFile == null) {
      return;
    }

    final VideoPlayerController vController = kIsWeb
        ? VideoPlayerController.network(videoFile!.path)
        : VideoPlayerController.file(File(videoFile!.path));

    videoPlayerListener = () {
      if (videoController != null && videoController!.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) {
          setState(() {});
        }
        videoController!.removeListener(videoPlayerListener!);
      }
    };
    vController.addListener(videoPlayerListener!);
    await vController.setLooping(true);
    await vController.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        imageFile = null;
        videoController = vController;
      });
    }
    await vController.play();
  }

  Future<void> resumeVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void _showCameraException(CameraException e) {
    print(e.code+e.description.toString());
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }


  Future<List<String>> getVideoPromptQuestions() async {
   // List<String> messages = await ApiRepository().fetchVideoPromptQuestions();
    List<String> messages = ["asas","asas"];
    selectedVideoPromptMessage = messages[0];
    return messages;
  }
}
