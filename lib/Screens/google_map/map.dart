import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterbestplace/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  var _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(35.504987, 11.043340),
    zoom: 14.4746,
  );

  Future getPostion() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      AwesomeDialog(
        context: context,
        title: 'services',
        body: Text('Activate the localisation in your smartphone'),
      )..show();
      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission();
      }
    }

    per = await Geolocator.checkPermission();
    print(services);
    print('///////////////////// per : $per');
  }

  @override
  void initState() {
    getPostion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ElevatedButton(
        child: Text(
          "button",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w100)),
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }*/
}

//KeyAPI android : AIzaSyAp6_rBkKNIbEe0QLj5rn5IuBYV_EpoJr4
//keyAPI web: AIzaSyCNKbddvj20I2bn-fJiCZWGFBRVv2DbOns