import 'dart:async';

import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';

class NavigationScreen extends StatefulWidget {

  String value;
  NavigationScreen({Key key, this.value, this.userData}) : super(key: key);
  static const String id = 'navigation_screen';
final List<String> userData;
  //final String dest;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override

  _NavigationScreen createState() => _NavigationScreen(value, userData);
}

class _NavigationScreen extends State<NavigationScreen> {
  List<String> loginInfo;
  String value;
  _NavigationScreen(this.value, this.loginInfo);

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  Position currentPosition;

  //Location myUserLocation;
  var lng, lat;
  static LatLng initialPosition;

  initState() {
    super.initState();
    //loading = true;
    getUserLocation();
    print("dest " + value);
  }

  Future getUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //currentPosition = position;
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
      print(lat);
      print(lng);
    });

    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print(isLocationServiceEnabled);
    print(lat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(userData: loginInfo),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Navigation'),
      ),
      body: Stack(
        children: [
            lat == null || lng == null ? Container() :
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 13.0,
              ),
            ),
        ],


      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onMapCreated(GoogleMapController controller){
    setState(() {
      newGoogleMapController = controller;
    });
  }
}