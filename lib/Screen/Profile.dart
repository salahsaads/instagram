import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/firebase/Firebase.dart';
import 'package:instagram/provider/provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.UserUid});
  final UserUid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late List Following;

  bool? Is_Following;
  int? count_post;
  void User() async {
    var snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Following = snap.data()!['following'];
    var snap_user = await FirebaseFirestore.instance
        .collection('post')
        .where('uid', isEqualTo: widget.UserUid)
        .get();
    count_post = snap_user.docs.length;
    setState(() {
      Is_Following = Following.contains(widget.UserUid);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userprovider = Provider.of<Userprovider>(context, listen: false);
    userprovider.fetchUser(UserUid: widget.UserUid);
    User();
  }

  @override
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
                    Column(
                      children: [
                        Text(
                          '${count_post ?? 0}',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          'Posts',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${userprovider.getUser!.followers.length}',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
                          'Followers',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${userprovider.getUser!.following.length}',
                          style: TextStyle(fontSize: 18),
                        ),
                        const Text(
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
                      color:
                          Is_Following == true ? Colors.red : Colors.grey[900],
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Is_Following == true
                              ? Colors.red
                              : Colors.grey[900]),
                      onPressed: () {
                        if (widget.UserUid !=
                            FirebaseAuth.instance.currentUser!.uid) {
                          if (Is_Following == true) {
                            //UnFollow

                            FireStoreData()
                                .Un_follow_User(userID: widget.UserUid);
                            userprovider.dcrease_Following();
                            setState(() {
                              Is_Following = false;
                            });
                          } else {
                            FireStoreData().follow_User(userID: widget.UserUid);
                            userprovider.increase_Following();
                            setState(() {
                              Is_Following = true;
                            });
                          }
                        }
                      },
                      child: widget.UserUid ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? const Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.white),
                            )
                          : Is_Following == true
                              ? const Text(
                                  'UnFollow',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
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
                        return const Center(
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
