import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterbestplace/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutterbestplace/Controllers/maps_controller.dart';

class PlaceMap extends StatefulWidget {
  @override
  State<PlaceMap> createState() => LocationState();
}

class LocationState extends State<PlaceMap> {
  var _controller = Completer();
  CameraPosition _kGooglePlex;
  Position cp;
  Set<Marker> marker = {
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(35.5049812224640, 11.043470115161800))
  };
  MarkerController controllerMarker = MarkerController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: [
          _kGooglePlex == null
              ? CircularProgressIndicator()
              : Container(
                  child: GoogleMap(
                    markers: marker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                  ),
                  height: 500,
                ),
          ElevatedButton(
            child: Text(
              "button",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // controllerMarker.PlaceMap(lat, long);
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
}
