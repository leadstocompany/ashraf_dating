import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ApiRepository{
  checkIfAccountExsist(String string) {}

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }

  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future<String> uploadFileAndGetDownloadUrl(String destination, File file) async {
    if (file == null) return "Cannot Upload Empty File";


    try {
      //final fileName = basename(file!.path);


      String id = FirebaseAuth.instance.currentUser!.uid;

      String destinationForImage = id.toString()+"/"+destination;


      UploadTask? task = ApiRepository.uploadFile(destinationForImage, file!);



      if (task == null) return "Error Occured";

      final snapshot = await task!.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();

      print('Download-Link: $urlDownload');
      print(destinationForImage + "Files Added Successfully");
      return urlDownload;
    } on FirebaseException catch (e) {
      return "Firebase Exception: "+e.message.toString();
    }
  }
  
}