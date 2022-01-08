import 'package:flutter/material.dart';
import 'package:flutterbestplace/Controllers/numbers_controller.dart';
import 'package:get/get.dart';

class NumbersWidget extends StatelessWidget {
  final Following;
  final Followers;
  final Posts;
  final String idCurret;
  final String iduser;
  const NumbersWidget({
    Key key,
    this.Following,
    this.Followers,
    this.Posts,
    this.idCurret,
    this.iduser,
  }) : super(key: key);
  @override
  Widget build(
          BuildContext
              context) => /* GetBuilder<NumbersController>(
      init: NumbersController(),
      builder: (controller) =>*/
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '${Posts}', 'Posts'),
          buildDivider(),
          buildButton(context, '${Following}', 'Following'),
          buildDivider(),
          buildButton(context, '${Followers}', 'Followers'),
        ],
        // )
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(
    BuildContext context,
    String value,
    String text,
  ) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 3),
        onPressed: () async {
          NumbersController numbers = NumbersController();
          await numbers.addFollow(idCurret, iduser);
        },
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
