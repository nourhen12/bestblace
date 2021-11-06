import 'package:flutter/material.dart';
import 'package:flutterbestplace/components/button_widget.dart';
import 'package:flutterbestplace/components/photo_profil.dart';
import 'package:flutterbestplace/components/numbers_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterbestplace/models/user.dart';
import 'package:get/get.dart';
import 'package:flutterbestplace/Controllers/user_controller.dart';

class Body extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    UserController _controller = Get.put(UserController());
    //User user = User();
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        PhotoProfile(
          imagePath: "assets/images/profil_defaut.jpg",
          onClicked: () async {
            Get.toNamed('/editprofil');
          },
        ),
        const SizedBox(height: 24),
        buildName(_controller.userController),
        const SizedBox(height: 24),
        // Center(child:buildRating()),
        //const SizedBox(height: 24),
        Center(
            child: ButtonWidget(
          text: 'Upgrade To Profile',
          onClicked: () {
            Get.toNamed('/image');
          },
        )),
        const SizedBox(height: 24),
        NumbersWidget(),
      ],
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.fullname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildRating() => RatingBar.builder(
        initialRating: 2.5,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      );
}
