import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/model/user_model.dart';

class FireStoreData {
  Future<UserModel> UserData() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    UserModel userdata = UserModel.fromJson(data.data());
    return userdata;
  }
}
