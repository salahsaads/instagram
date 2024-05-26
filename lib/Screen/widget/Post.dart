import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram/Screen/comment.dart';

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
                  style: TextStyle(
                    fontSize: 22,
                  ),
                )
              ],
            ),
          ),
          Image.network(userData['postImage'],
              height: h * .5, width: double.infinity, fit: BoxFit.fill),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
            ],
          ),
          const Text(
            '1K',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${userData['des']}',
            style: TextStyle(
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
                      builder: (context) => const CommentScreen()));
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
