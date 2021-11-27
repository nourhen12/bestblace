import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutterbestplace/components/photo_profil.dart';
import 'package:flutterbestplace/components/rounded_input_field.dart';
import 'package:flutterbestplace/models/user.dart';
import 'package:get/get.dart';
import 'package:flutterbestplace/Controllers/user_controller.dart';
import 'package:flutterbestplace/components/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutterbestplace/models/Utility.dart';
import 'package:xfile/xfile.dart';
import 'package:cryptoutils/cryptoutils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, GridFS;
import 'package:multipart/multipart.dart';
import 'dart:html' as html;
//import 'package:dio/src/form_data.dart';
// Pick an image
class Body extends StatefulWidget {
  String title="";

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<Body> {
  UserController _controller = Get.put(UserController());
  final picker = ImagePicker();
  File file;
  var serverReceiverPath = "https://bestpkace-api.herokuapp.com/uploadsavatar/avatar/619e51df4e9b440023224efd";

  Future<String> uploadImage(filename) async {
   /* var request = http.MultipartRequest('POST', Uri.parse(serverReceiverPath));
    request.files.add(await http.MultipartFile.fromPath('avatar', filename));
    var res = await request.send();
    return res.reasonPhrase;*/
    var request = http.MultipartRequest('POST', Uri.parse(serverReceiverPath))
      ..files.add(await http.MultipartFile.fromPath(
          'avatar', filename,
          contentType: MediaType('application', 'x-tar')));
    var response = await request.send();
    if (response.statusCode == 200) print('Uploaded!');
  }

  Future chooseFile() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        file = File(image.path);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter File Upload Example',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            file != null
                ? Container(
              height: 160.0,
              width: 160.0,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: ExactAssetImage(file.path),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.red, width: 5.0),
                borderRadius:
                BorderRadius.all(const Radius.circular(20.0)),
              ),
            )
                : SizedBox(
              width: 0.0,
            ),
            SizedBox(
              height: 100.0,
            ),
            file != null
                ? RaisedButton(
              child: Text("Upload Image"),
              onPressed: () async {
                var res = await uploadImage(file.path);
                setState(() {
                  print(res);
                });
              },
            )
                : SizedBox(
              width: 50.0,
            ),
            file == null
                ? RaisedButton(
              child: Text("Open Gallery"),
              onPressed: () async {


              chooseFile();
              },
            )
                : SizedBox(
              width: 0.0,
            )
          ],
        ),
      ),
    );
  }
}

