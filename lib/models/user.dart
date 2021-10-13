class User {
  String id;
  String fullname;
  String email;
  String password;
  String avatar;
  User({this.id, this.fullname, this.email, this.password, this.avatar});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id : json['_id'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
    );
  }
}