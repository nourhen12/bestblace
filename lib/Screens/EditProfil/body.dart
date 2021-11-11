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
    var userid = _controller.idUser;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        PhotoProfile(
          imagePath: "assets/images/profil_defaut.jpg",
          isEdit: true,
          onClicked: () async {
            /*final image =
                await ImagePicker().getImage(source: ImageSource.gallery);*/
            final ImagePicker _picker = ImagePicker();
            final XFile imagepicker =
                await _picker.pickImage(source: ImageSource.gallery);
            if (imagepicker != null) {
              print('image : ${imagepicker.path}');
              final imageFile = XFile(imagepicker.path);
              print('imagefile $imageFile');
            }
          },
        ),
        const SizedBox(height: 24),
        RoundedInputField(
          hintText: user.fullname,
          onChanged: (value) {
            NewName = value;
          },
        ),
        const SizedBox(height: 24),
        RoundedInputField(
          hintText: user.email,
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
                'id : $userid , name : $NewName , email : $NewEmail , phone : $NewPhone , ville : $NewVille');
            _controller.updateUser(
                user.id, NewName, NewEmail, NewPhone, NewVille);
          },
        ),
      ],
    );
  }
}
