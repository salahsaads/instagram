class UserModel {
  final String username, email, password, imageUrl, uid;
  final List followers;
  final List following;
  UserModel(this.email, this.username, this.password, this.imageUrl, this.uid,
      this.followers, this.following);

  factory UserModel.fromJson(jsonData) {
    return UserModel(
        jsonData['email'],
        jsonData['username'],
        jsonData['password'],
        jsonData['imageUrl'],
        jsonData['uid'],
        jsonData['followers'],
        jsonData['following']);
  }
}
