import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostCard extends StatelessWidget {
  PostCard({super.key});
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
                const CircleAvatar(
                  radius: 30,
                ),
                SizedBox(
                  width: w * .05,
                ),
                const Text(
                  'name ',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                )
              ],
            ),
          ),
          Image.asset('assets/Snapchat-295033281.jpg',
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
          const Text(
            'good',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {},
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
