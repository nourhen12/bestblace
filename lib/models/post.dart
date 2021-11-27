class Post {
  String id;
  String body;
  String Iduser;
  String img;
  String date;

  Post({
    this.id,
    this.body,
    this.Iduser,
    this.img,
    this.date,
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      body: json['body'],
      Iduser: json['user'],
      img: json['img'],
      date: json['date'],
    );
  }
  Map<String, dynamic> toJson() => {
        '_id': id,
        'body': body,
        'user': Iduser,
        'img': img,
        'date': date,
      };
}
