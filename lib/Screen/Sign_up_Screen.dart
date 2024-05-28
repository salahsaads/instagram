// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Screen/bottonBar.dart';
import 'package:instagram/Screen/login_Screen.dart';
import 'package:instagram/model/user_model.dart';
import 'package:uuid/uuid.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  File? pickedImage;
  String? URl;
  void selectImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      var Selected = File(image.path);
      setState(() {
        pickedImage = Selected;
      });
    }
  }

  bool isloading = false;
  void sing_up({required String emailAddress, required String password1}) async {
    setState(() {
      isloading = true;
    });
    try {
      final uuid = const Uuid().v4();
      final ref = FirebaseStorage.instance
          .ref()
          .child('usersImage')
          .child('${uuid}jpg');
      await ref.putFile(pickedImage!);
      final ImageUrl = await ref.getDownloadURL();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password1,
      );
      UserModel data = UserModel(
          email: email.text,
          username: name.text,
          password: password.text,
          imageUrl: ImageUrl,
          uid: FirebaseAuth.instance.currentUser!.uid,
          followers: [],
          following: []);
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data.convertTamp());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BouttonBar(),
          ));

      setState(() {
        isloading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .1,
              ),
              const Text(
                'instagram',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
              SizedBox(
                height: height * .05,
              ),
              Stack(
                children: [
                  pickedImage != null
                      ? CircleAvatar(
                          radius: 36,
                          backgroundImage: FileImage(pickedImage!),
                        )
                      : const CircleAvatar(
                          radius: 36,
                        ),
                  Positioned(
                      top: 25,
                      left: 25,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(Icons.add),
                      )),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your username ';
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'name',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'please enter a vaild email';
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'email',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return 'please enter a vaild   Password';
                          }
                        },
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.visibility_off),
                            hintText: 'password',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ],
                  )),
              SizedBox(
                height: height * .05,
              ),
              GestureDetector(
                onTap: () {
                  formkey.currentState!.save();
                  if (formkey.currentState!.validate()) {
                    sing_up(password1: password.text, emailAddress: email.text);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: height * .05,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: isloading == true
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Sing Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    'do you have an account?',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
