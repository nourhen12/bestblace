import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutterbestplace/components/numbers_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutterbestplace/Controllers/user_controller.dart';
import 'package:flutterbestplace/models/user.dart';
import 'package:flutterbestplace/constants.dart';
import 'package:flutterbestplace/Controllers/maps_controller.dart';
import 'package:flutterbestplace/Controllers/rate_controller.dart';
import 'package:flutterbestplace/models/Data.dart';
//google maps :
import 'package:google_maps_flutter/google_maps_flutter.dart';
//geolocator :
import 'package:geolocator/geolocator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isOpen = false;
  bool isLoading = false;
  PanelController _panelController = PanelController();
  UserController _controller = Get.put(UserController());
  RteController controllerRate = Get.put(RteController());
  MarkerController controllerMarker = MarkerController();
  CameraPosition _kGooglePlex;
  final _completer = Completer();
  Position cp;
  Set<Marker> markers = {};
  String postOrientation = "grid";
  double rate;
  //List<Map<String> _rating = [1,2,3.5,2,2.5,4,4.5,2.5,2.5];//24.5

  Future<Position> getLateAndLate() async {
    Data data = await controllerMarker.MarkerById(
        _controller.userController.value.marker[0]);
    print("*******************************");
    var latitude = data.payload['latitude'];
    var longitude = data.payload['longitude'];
    print(latitude);
    print(longitude);
    _kGooglePlex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    markers.add(
        Marker(markerId: MarkerId("1"), position: LatLng(latitude, longitude)));
    setState(() {});
  }

  @override
  void initState() {
    controllerRate.getRate();
    controllerRate.CalculRating();
    getLateAndLate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Obx(
            () => FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://bestpkace-api.herokuapp.com/uploadsavatar1/${_controller.userController.value.avatar}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.3,
            child: Container(
              color: Colors.white,
            ),
          ),
          SlidingUpPanel(
            controller: _panelController,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
            minHeight: MediaQuery.of(context).size.height * 0.35,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            body: GestureDetector(
              onTap: () => _panelController.close(),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            panelBuilder: (ScrollController controller) =>
                _panelBody(controller),
            onPanelSlide: (value) {
              if (value >= 0.2) {
                if (!_isOpen) {
                  setState(() {
                    _isOpen = true;
                  });
                }
              }
            },
            onPanelClosed: () {
              setState(() {
                _isOpen = false;
              });
            },
          ),
        ],
      ),
    );
  }

  /// WIDGETS

  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Widget buildName(User user) => Column(children: [
        Text(
          user.fullname,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        ),
      ]);
  Widget buildRating(double Rating) {
    return RatingBar.builder(
      initialRating: Rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      glow: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          rate = rating;
          print(rate);
        });
        /*setState(() {
         _rating.add(rating);
        print("_rating : $_rating");
        });*/
      },
      updateOnDrag: false,
    );
  }

  _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate This Places'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please leave a star rating.'),
                buildRating(1.0),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('rating'),
              onPressed: () {
                print("///////////////////////////");
                print(rate);

                controllerRate.addRate(rate, _controller.idController);
                // print("liste rates  cout : ${controllerRate.Rates.value.length}");
                setState(() {
                  controllerRate.CalculRating();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

/*
(new) RatingBar RatingBar.builder({
  Widget Function(BuildContext, int) itemBuilder,
  void Function(double) onRatingUpdate,
  Color glowColor,
  double maxRating,
  TextDirection textDirection,
  Color unratedColor,
  bool allowHalfRating = false,
  Axis direction = Axis.horizontal,
  bool glow = true,
  double glowRadius = 2,
  bool ignoreGestures = false,
  double initialRating = 0.0,
  int itemCount = 5,
  EdgeInsetsGeometry itemPadding = EdgeInsets.zero,
  double itemSize = 40.0,
  double minRating = 0,
  bool tapOnlyMode = false,
  bool updateOnDrag = false,
  WrapAlignment wrapAlignment = WrapAlignment.start,
})
*/
  /// Panel Body
  SingleChildScrollView _panelBody(ScrollController controller) {
    double hPadding = 40;

    return SingleChildScrollView(
      controller: controller,
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Obx(
                  () => _titleSection(_controller.userController.value),
                ),

                MaterialButton(
                    onPressed: () {
                      print("okkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                      _showMyDialog();
                    },
                    child: Center(
                        child: buildRating(controllerRate.Rating.value))),
                /* Obx(
                  () => NumbersWidget(
                    Following: _controller.userController.value.following,
                    Followers: _controller.userController.value.followers,
                    Posts: _controller.imageList,
                    idCurret: _controller.idController,
                    iduser: "61b6821a8a3ffd0023dc6323",
                  ),
                ),*/
                // _actionSection(hPadding: hPadding),
              ],
            ),
          ),
          IconTap(),
          buildProfilePosts(),
        ],
      ),
    );
  }

//
  buildProfilePosts() {
    if (_controller.imageList.isEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/vide.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                "No Posts",
                style: TextStyle(
                  color: Colors.pink[50],
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (postOrientation == "grid") {
      return GridView.builder(
        primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: _controller.imageList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_controller.imageList[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (postOrientation == "map") {
      return Column(
        children: [
          _kGooglePlex == null
              ? CircularProgressIndicator()
              : Container(
                  child: GoogleMap(
                    markers: markers,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (controller) {
                      _completer.complete(controller);
                    },
                  ),
                  height: 500,
                ),
        ],
      );
    }
  }

//IconTap
  Widget IconTap() => Container(
        color: kPrimaryLightColor,
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  postOrientation = "grid";
                });
              },
              icon: Icon(Icons.image, color: kPrimaryColor, size: 30.0),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  postOrientation = "map";
                });
              },
              icon: Icon(Icons.map, color: kPrimaryColor, size: 30.0),
            )
          ],
        ),
      );

  /// Action Section
  Row _actionSection({double hPadding}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Visibility(
          visible: !_isOpen,
          child: Expanded(
            child: OutlineButton(
              onPressed: () => _panelController.open(),
              borderSide: BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                'VIEW PROFILE',
                style: TextStyle(
                  fontFamily: 'NimbusSanL',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_isOpen,
          child: SizedBox(
            width: 16,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: _isOpen
                  ? (MediaQuery.of(context).size.width - (2 * hPadding)) / 1.6
                  : double.infinity,
              child: FlatButton(
                onPressed: () => print('Message tapped'),
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'MESSAGE',
                  style: TextStyle(
                    fontFamily: 'NimbusSanL',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Title Section
  Column _titleSection(User user) {
    return Column(
      children: <Widget>[
        Text(
          user.fullname,
          style: TextStyle(
            fontFamily: 'NimbusSanL',
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        buildEditIcon(kPrimaryColor),
        SizedBox(
          height: 8,
        ),
        Text(
          user.email,
          style: TextStyle(
            fontFamily: 'NimbusSanL',
            fontStyle: FontStyle.italic,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          user.phone,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 5,
          child: IconButton(
            onPressed: () {
              Get.toNamed('/editprofil');
            },
            icon: Icon(
              Icons.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
}

class Completer {
  void complete(GoogleMapController controller) {}
}
