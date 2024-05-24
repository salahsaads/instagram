import 'package:flutter/material.dart';
import 'package:instagram/firebase/Firebase.dart';
import 'package:instagram/model/user_model.dart';

class Userprovider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUser {
    return userModel;
  }

  void fetchUser() async {
    UserModel user = await FireStoreData().UserData();
    userModel = user;
    notifyListeners();
  }
}
