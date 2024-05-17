import 'package:flutter/material.dart';
import 'package:instagram/Screen/widget/Post.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    // ignore: unused_local_variable
    double w = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Instagram',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.logout))
                  ],
                ),
                SizedBox(
                  height: h * .15,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PostCard();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
