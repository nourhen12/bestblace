import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterbestplace/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
//google maps :
import 'package:google_maps_flutter/google_maps_flutter.dart';
//geolocator :
import 'package:geolocator/geolocator.dart';

class Map extends StatelessWidget {
  final double latitude = 35.5049812224640;
  final double longitude = 11.043470115161800;
  final bool Draggable;
  final String Title;
  final VoidCallback onClicked;

  const Map(
      {Key key,
      //  this.latitude,
      //  this.longitude,
      this.Draggable,
      this.Title,
      this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(35.5049812224640, 11.043470115161800),
      zoom: 15.4746,
    );
    var _controller = Completer();
    Set<Marker> marker = {
      Marker(
          markerId: MarkerId("1"),
          draggable: Draggable,
          infoWindow: InfoWindow(title: Title, onTap: onClicked),
          position: LatLng(35.5049812224640, 11.043470115161800))
    };

    return Column(children: [
      _kGooglePlex == null
          ? CircularProgressIndicator()
          : Container(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
              ),
            )
    ]);
  }
}
