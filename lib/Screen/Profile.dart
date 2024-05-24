import 'package:flutter/material.dart';
import 'package:instagram/provider/provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
                    Column(
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
                    Column(
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
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '${userprovider.getUser!.username}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 5 / 3,
                  children: List.generate(5, (index) {
                    return Image.asset(
                      'assets/Snapchat-295033281.jpg',
                      fit: BoxFit.fill,
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
