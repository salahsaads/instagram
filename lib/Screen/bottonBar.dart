import 'package:flutter/material.dart';

class BouttonBar extends StatefulWidget {
  const BouttonBar({super.key});

  @override
  State<BouttonBar> createState() => _BouttonBarState();
}

class _BouttonBarState extends State<BouttonBar> {
  int _select = 0;
  final list = [
    Scaffold(
      backgroundColor: Colors.white,
    ),
    Scaffold(
      backgroundColor: Colors.amber,
    ),
    Scaffold(
      backgroundColor: Colors.amberAccent,
    ),
    Scaffold(
      backgroundColor: Colors.blue,
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
