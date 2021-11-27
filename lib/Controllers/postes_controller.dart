import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutterbestplace/models/post.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  final String url = "https://bestpkace-api.herokuapp.com/posts";
  Post postController = Post();

  Future<Post> CreatPost(String body, String img, String iduser) async {
    var req = <String, String>{
      'body': body,
      'user': iduser,
      'img': img,
    };
    final response = await http.post(
      Uri.parse("$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(req),
    );
    Map<String, dynamic> res = jsonDecode(response.body);
    print(res);

    if (res['status'] == 'success') {
      Get.toNamed('/login');
      print(Post.fromJson(res['payload']));
    } else {
      throw Exception('Failed to register user.');
    }
  }

//delate post
  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode == 200) {
      print("User deleted");
    } else {
      throw "Failed to delete a user.";
    }
  }
}
