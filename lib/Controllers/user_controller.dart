import 'package:get/get.dart';
import 'dart:convert';

import 'package:flutterbestplace/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  int posts = 12, following = 23, followers = 50;
  var id;
  var userController = User();

  //register :
  Future<User> signup(name, email, password) async {
    final String url = "https://bestpkace-api.herokuapp.com/users";
    final response = await http.post(
      Uri.parse("$url/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': name,
        'email': email,
        'password': password,
      }),
    );
    Map<String, dynamic> body = jsonDecode(response.body);
    print(body);

    if (body['status'] == 'success') {
      Get.toNamed('/login');
      return User.fromJson(body['payload']);
    } else {
      throw Exception('Failed to register user.');
    }
  }

  //connexion
  Future<User> login(email, password) async {
    final String url = "https://bestpkace-api.herokuapp.com/users";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse("$url/authenticate"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    Map<String, dynamic> body = jsonDecode(response.body);
    print(body);

    if (body['status'] == 'success') {
      var token = body['payload']['token'];
      await prefs.setString('token', token);
      userController = User.fromJson(body['payload']['user']);
      print('user :${userController.id}');
      Get.toNamed('/profil');
      //print('token : ${prefs.getString('token')}');
    } else {
      throw Exception('Failed to connected user.');
    }
  }

  Future<User> UserById(String id) async {
    final String url = "https://bestpkace-api.herokuapp.com/users";
    final response = await http.get(Uri.parse('$url/$id'));
    Map<String, dynamic> body = jsonDecode(response.body);
    User user = body['payload']['user'];

    if (response.statusCode == 200) {
      return user;
    } else {
      throw Exception('Failed to load a user');
    }
  }

  Future<User> updateUser(String id, User useredit) async {
    final String url = "https://bestpkace-api.herokuapp.com/users";
    final response = await http.put(
      Uri.parse("$url/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': useredit.fullname,
        'email': useredit.email,
        'password': useredit.password,
      }),
    );
    Map<String, dynamic> body = jsonDecode(response.body);
    print(body);

    if (body['status'] == 'success') {
      userController = User.fromJson(body['payload']['user']);
    } else {
      throw Exception('Failed to register user.');
    }
  }

  Future<void> deleteUser(String id) async {
    final String url = "https://bestpkace-api.herokuapp.com/users";
    final response = await http.delete(Uri.parse('$url/$id'));

    if (response.statusCode == 200) {
      print("User deleted");
    } else {
      throw "Failed to delete a user.";
    }
  }
}
