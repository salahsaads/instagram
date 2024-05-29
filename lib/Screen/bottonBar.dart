import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screen/Home.dart';
import 'package:instagram/Screen/Profile.dart';
import 'package:instagram/Screen/Search.dart';
import 'package:instagram/Screen/post_Screen.dart';

class BouttonBar extends StatefulWidget {
  const BouttonBar({super.key});

  @override
  State<BouttonBar> createState() => _BouttonBarState();
}

class _BouttonBarState extends State<BouttonBar> {
  int _select = 0;
  final list = [
    const Home(),
    const SearchScreen(),
    const PostScreen(),
    ProfileScreen(
      UserUid: FirebaseAuth.instance.currentUser!.uid,
    )
  ];

  void SelectedPage(index) {
    setState(() {
      _select = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_select],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        currentIndex: _select,
        onTap: SelectedPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 26,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 26,
              color: Colors.white,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 26,
              color: Colors.white,
            ),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 26,
              color: Colors.white,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
