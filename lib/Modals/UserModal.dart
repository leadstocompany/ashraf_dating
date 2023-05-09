import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String email;
  final String uid;


  UserModel(
      {required this.email,
        required this.uid,
        });

  Map<String, dynamic> toJson() => {
    "email": email,
    "uid": uid,
  };

  static UserModel? fromSnap (DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
    );
  }
}