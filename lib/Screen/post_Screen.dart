import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  File? pickedImage;
  String? URl;
  void selectImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      var Selected = File(image.path);
      setState(() {
        pickedImage = Selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    // ignore: unused_local_variable
    double w = MediaQuery.sizeOf(context).width;
    final comment = TextEditingController();
    final userprovider = Provider.of<Userprovider>(context);

    void upload_post() async {
      try {
        final uuid = Uuid().v4();
        final ref = FirebaseStorage.instance
            .ref()
            .child('postImage')
            .child(uuid + 'jpg');
        await ref.putFile(pickedImage!);
        final ImageUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('post').add({
          'username': userprovider.getUser!.username,
          'uid': userprovider.getUser!.uid,
          'userImage': userprovider.getUser!.imageUrl,
          'postImage': ImageUrl,
          'postid': uuid,
          'des': comment.text
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Done')));

        setState(() {
          pickedImage = null;
          comment.text = '';
        });
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.cancel,
                      size: 26,
                    )),
                const Text(
                  "New Post",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      upload_post();
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(fontSize: 22),
                    )),
              ],
            ),
            pickedImage == null
                ? SizedBox(
                    height: h * .4,
                  )
                : Container(
                    height: h * .4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill, image: FileImage(pickedImage!))),
                  ),
            // : Image.file(pickedImage!,
            //     height: h * .4, width: double.infinity, fit: BoxFit.fill),
            IconButton(
                onPressed: () {
                  selectImage();
                },
                icon: const Icon(Icons.upload)),
            TextField(
              controller: comment,
              maxLines: 15,
              decoration: const InputDecoration(
                  hintText: 'Add Comment',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ],
        ),
      ),
    ));
  }
}
