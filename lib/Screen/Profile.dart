import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/provider/provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.UserUid});
  final UserUid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userprovider = Provider.of<Userprovider>(context, listen: false);
    userprovider.fetchUser(UserUid: widget.UserUid);
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    // ignore: unused_local_variable
    double w = MediaQuery.sizeOf(context).width;

    final userprovider = Provider.of<Userprovider>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        radius: 36,
                        backgroundImage:
                            NetworkImage(userprovider.getUser!.imageUrl)),
                    const Column(
                      children: [
                        Text(
                          '12',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Text(
                          '1K',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Text(
                          '501K',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Following',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    userprovider.getUser!.username,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[900]),
                      onPressed: () {},
                      child: widget.UserUid ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              'Follow',
                              style: TextStyle(color: Colors.white),
                            )),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('post')
                        .where('uid', isEqualTo: widget.UserUid)
                        .get(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 5 / 3,
                          children:
                              List.generate(snap.data!.docs.length, (index) {
                            return Image.network(
                              snap.data!.docs[index]['postImage'],
                              fit: BoxFit.fill,
                            );
                          }),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
