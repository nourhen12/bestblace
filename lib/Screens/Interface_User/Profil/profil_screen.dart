import 'package:flutter/material.dart';
import 'package:flutterbestplace/components/appbar_widget.dart';
import 'package:flutterbestplace/Screens/Interface_User/Profil/components/body.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }
}
