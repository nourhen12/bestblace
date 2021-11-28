import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterbestplace/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geocoding/geocoding.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  var _controller = Completer();
Position cp;
var lat;
var long;
CameraPosition _kGooglePlex ;

  Future getPer() async {
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
    return per;
  }

  Future<Position> getLateAndLate() async {
    cp = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cp.latitude;
    long = cp.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng( lat, long),
      zoom: 15.4746,
    );
    setState(() {

    });
  }
  @override
  void initState() {
    getPer();
    getLateAndLate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:Column(
        children:[
          _kGooglePlex == null ? CircularProgressIndicator():
          Container( child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
          ),
            height: 500,
            width: 400,
          ),
        ElevatedButton(
        child: Text(
          "button",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async{
          cp = await getLateAndLate();
          print("lat : ${cp.latitude} ");
          print("long : ${cp.longitude} ");
         // List<Placemark> placemarks = await placemarkFromCoordinates(cp.latitude, cp.longitude);
         // print("position : ${placemarks} ");
       // List<Location> locations = await locationFromAddress("haddad mahdia");
         List<Placemark> placemarks = await placemarkFromCoordinates(35.4994896, 11.0583794);
          print("position : ${placemarks} ");
        },
        style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w100)),
      ),
    ],
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
