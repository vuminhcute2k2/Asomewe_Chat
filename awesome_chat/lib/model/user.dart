// TODO Implement this library.
class User {
  final String email;
  final String numberphone;
  final String uid;
  final String image;
  final String birthday;
  final String fullname;
  final String password;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.numberphone,
    required this.uid,
    required this.image,
    required this.birthday,
    required this.fullname,
    required this.password,
    required this.followers,
    required this.following,
  });

  Map<String,dynamic> toJson() => {
    "email" : email,
    "image" : image,
    "numberphone" : numberphone,
    "birthday" : birthday,
    "uid" : uid,
    "fullname" : fullname,
    "password" : password,
    "followers" : followers,
    "following" : following,
  };
}
