import 'package:flutter/material.dart';
import 'package:flutterbestplace/Controllers/user_controller.dart';
import 'package:get/get.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<UserController>(
      init: UserController(),
      builder: (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton(context, '${controller.posts}', 'Posts'),
              buildDivider(),
              buildButton(context, '${controller.following}', 'Following'),
              buildDivider(),
              buildButton(context, '${controller.followers}', 'Followers'),
            ],
          ));
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
