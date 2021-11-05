import 'package:flutter/material.dart';
import 'package:flutterbestplace/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final double nb;
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.nb,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * nb,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
