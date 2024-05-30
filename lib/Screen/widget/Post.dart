import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screen/comment.dart';
import 'package:instagram/firebase/Firebase.dart';

class PostCard extends StatelessWidget {
  PostCard({super.key, required this.userData});
  Map<String, dynamic> userData;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userData['userImage']),
                ),
                SizedBox(
                  width: w * .05,
                ),
                Text(
                  '${userData['username']}',
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
                userData['uid'] == FirebaseAuth.instance.currentUser!.uid
                    ? IconButton(
                        onPressed: () {
                          FireStoreData().delate_post(postUser: userData);
                        },
                        icon: const Icon(Icons.remove))
                    : Container()
              ],
            ),
          ),
          Image.network(userData['postImage'],
              height: h * .5, width: double.infinity, fit: BoxFit.fill),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  FireStoreData().add_post_like(postUser: userData);
                },
                icon: Icon(Icons.favorite,
                    color: userData['likes'] != []
                        ? userData['likes'].contains(
                                FirebaseAuth.instance.currentUser!.uid)
                            ? Colors.red
                            : Colors.white
                        : Colors.white),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
            ],
          ),
          Text(
            '${userData['likes'].length} likes',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${userData['des']}',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommentScreen(
                            PostId: userData['postid'],
                          )));
            },
            child:
                const Text('Add Comment', style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            '1 hour age',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
