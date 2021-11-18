import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterbestplace/components/photo_profil.dart';
import 'package:flutterbestplace/components/rounded_input_field.dart';
import 'package:flutterbestplace/models/user.dart';
import 'package:get/get.dart';
import 'package:flutterbestplace/Controllers/user_controller.dart';
import 'package:flutterbestplace/components/rounded_button.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<Body> {
  UserController _controller = Get.put(UserController());
  var NewName = null;
  var NewEmail = null;
  var NewPhone = null;
  var NewVille = null;

  @override
  Widget build(BuildContext context) {
    User user = _controller.userController;
    String avaterapi = user.avatar;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        PhotoProfile(
          imagePath:
              "https://bestpkace-api.herokuapp.com/uploadsavatar/$avaterapi",
          isEdit: true,
          onClicked: () async {
            _controller.uploadAvatar(user.id,'image', File('testimage.png'));
          },
        ),
        const SizedBox(height: 24),
        RoundedInputField(
          hintText: user.fullname,
          icon: Icons.person,
          onChanged: (value) {
            NewName = value;
          },
        ),
        const SizedBox(height: 24),
        RoundedInputField(
          hintText: user.email,
          icon: Icons.email,
          onChanged: (value) {
            NewEmail = value;
          },
        ),
        RoundedInputField(
          hintText: "Your Phone",
          icon: Icons.phone,
          onChanged: (value) {
            NewPhone = value;
          },
        ),
        RoundedInputField(
          hintText: "Your Ville",
          icon: Icons.location_city,
          onChanged: (value) {
            NewVille = value;
          },
        ),
        RoundedButton(
          text: "Save",
          press: () {
            print(
                'id : $user.id  , name : $NewName , email : $NewEmail , phone : $NewPhone , ville : $NewVille');
            _controller.updateUser(
                user.id, NewName, NewEmail, NewPhone, NewVille);
          },
        ),
      ],
    );
  }
}
