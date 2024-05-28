import 'package:cloud_firestore/cloud_firestore.dart';
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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('post')
                    .doc(widget.PostId)
                    .collection('comment')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return ListTile(
                            title: Text('${data['name']}'),
                            subtitle: Text('${data['comment']}'),
                            leading: CircleAvatar(
                              radius: 36,
                              backgroundImage: NetworkImage(data['userImage']),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite)),
                          );
                        });
                  }
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
                                      name: userprovider.userModel!.username,
                                      comment: comment,
                                      userImage:
                                          userprovider.userModel!.imageUrl,
                                      uid: userprovider.userModel!.uid,
                                      postId: widget.PostId);
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
