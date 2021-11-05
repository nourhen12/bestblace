class User {
  String id;
  String fullname;
  String email;
  String password;
  String phone;
  String ville;
  String role;
  String avatar;
  User(
      {this.id,
      this.fullname,
      this.email,
      this.password,
      this.phone,
      this.ville,
      this.role,
      this.avatar = "assets/images/profil_defaut.jpg"});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullname: json['fullname'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      ville: json['ville'],
      role: json[' role'],
      avatar: json['avatar'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'password': password,
        'phone': phone,
        'ville': ville,
        'role': role,
        'avatar': avatar,
      };
}
