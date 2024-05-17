import 'package:flutter/material.dart';
import 'package:instagram/Screen/Sign_up_Screen.dart';
import 'package:instagram/Screen/bottonBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: BouttonBar(),
    );
  }
}
