import 'package:flutter/material.dart';
import 'package:instagram/firebase/Firebase.dart';
import 'package:instagram/provider/provider.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.PostId});

  final PostId;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<Userprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comment',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text('name'),
                    subtitle: const Text('Comment'),
                    leading: const CircleAvatar(
                      radius: 36,
                    ),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.favorite)),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(userprovider.userModel!.imageUrl),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      controller: comment,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (comment.text != '') {
                                  FireStoreData().add_comment(
                                      comment: comment,
                                      userImage:
                                          userprovider.userModel!.imageUrl,
                                      uid: userprovider.userModel!.uid,
                                      posiId: widget.PostId);
                                }
                                comment.clear();
                              },
                              icon: Icon(Icons.send)),
                          hintText: 'add comment',
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue),
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
