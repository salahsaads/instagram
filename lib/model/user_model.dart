class UserModel {
  final String username, email, password, imageUrl, uid;
  final List followers;
  final List following;

  UserModel(
      {required this.email,
      required this.username,
      required this.password,
      required this.imageUrl,
      required this.uid,
      required this.followers,
      required this.following});

  factory UserModel.fromJson(jsonData) {
    return UserModel(
        email: jsonData['email'],
        username: jsonData['username'],
        password: jsonData['password'],
        imageUrl: jsonData['imageUrl'],
        uid: jsonData['uid'],
        followers: jsonData['followers'],
        following: jsonData['following']);
  }

  Map<String, dynamic> convertTamp() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'imageUrl': imageUrl,
      'uid': uid,
      'followers': followers,
      'following': following
    };
  }
}
