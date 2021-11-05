import 'package:flutter/material.dart';
import 'package:flutterbestplace/components/photo_profil.dart';
import 'package:flutterbestplace/components/textfield_edit.dart';
import 'package:flutterbestplace/models/user.dart';
import 'package:get/get.dart';
import 'package:flutterbestplace/Controllers/user_controller.dart';
import 'package:flutterbestplace/components/rounded_button.dart';

class Body extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<Body> {
  UserController _controller = Get.put(UserController());
  var name;
  var mail;
  @override
  Widget build(BuildContext context) {
    User user = _controller.userController;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        PhotoProfile(
          imagePath: "assets/images/profil_defaut.jpg",
          isEdit: true,
          onClicked: () async {},
        ),
        const SizedBox(height: 24),
        TextFieldedit(
          label: 'Full Name',
          text: user.fullname,
          onChanged: (value) {
            name = value;
          },
        ),
        const SizedBox(height: 24),
        TextFieldedit(
          label: 'Email',
          text: user.email,
          onChanged: (value) {
            mail = value;
          },
        ),
        TextFieldedit(
          label: 'Password',
          text: user.password,
          onChanged: (value) {},
        ),
        RoundedButton(
          text: "Save",
          press: () {
            var id = user.id;
            _controller.updateUser(id, name, mail);
          },
        ),
      ],
    );
  }
}
