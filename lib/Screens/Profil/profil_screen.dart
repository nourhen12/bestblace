import 'package:flutter/material.dart';
import 'package:flutter_auth/components/appbar_widget.dart';
import 'package:flutter_auth/Screens/Profil/components/body.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
       // body: body(),
    );
  }
}