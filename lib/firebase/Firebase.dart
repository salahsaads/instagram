import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/model/user_model.dart';
import 'package:uuid/uuid.dart';

class FireStoreData {
  Future<UserModel> UserData({required userUID}) async {
    var data =
        await FirebaseFirestore.instance.collection('users').doc(userUID).get();

    UserModel userdata = UserModel.fromJson(data.data());
    return userdata;
  }

  add_post_like({required Map postUser}) async {
    if (postUser['likes'].contains(FirebaseAuth.instance.currentUser!.uid)) {
      await FirebaseFirestore.instance
          .collection('post')
          .doc(postUser['postid'])
          .update({
        'likes':
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
      });
    } else {
      await FirebaseFirestore.instance
          .collection('post')
          .doc(postUser['postid'])
          .update({
        'likes': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });
    }
  }

  delate_post({required Map postUser}) async {
    if (FirebaseAuth.instance.currentUser!.uid == postUser['uid']) {
      await FirebaseFirestore.instance
          .collection('post')
          .doc(postUser['postid'])
          .delete();
    }
  }

  add_comment(
      {required comment,
      required userImage,
      required uid,
      required postId,
      required name}) async {
    final uuid = const Uuid().v4();

    await FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('comment')
        .doc(uid)
        .set({
      'comment': comment.text,
      'userImage': userImage,
      'postId': postId,
      'commentid': uuid,
      'name': name
    });
  }

  follow_User({required userID}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'following': FieldValue.arrayUnion([userID])
    });

    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'followers': FieldValue.arrayUnion([
        FirebaseAuth.instance.currentUser!.uid,
      ])
    });
  }


   Un_follow_User({required userID}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'following': FieldValue.arrayRemove([userID])
    });

    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      'followers': FieldValue.arrayRemove([
        FirebaseAuth.instance.currentUser!.uid,
      ])
    });
  }
}
