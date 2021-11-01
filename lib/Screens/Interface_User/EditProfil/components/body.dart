import 'package:flutter/material.dart';
import 'package:flutterbestplace/components/photo_profil.dart';
import 'package:flutterbestplace/components/textfield_edit.dart';
import 'package:flutterbestplace/models/user.dart';

class Body extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<Body> {
  User user = User();

  @override
  Widget build(BuildContext context) {
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
          onChanged: (name) {},
        ),
        const SizedBox(height: 24),
        TextFieldedit(
          label: 'Email',
          text: user.email,
          onChanged: (email) {},
        ),
      ],
    );
  }
}
