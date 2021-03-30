import 'dart:async';

import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({Key key}) : super(key: key);
  static const String id = 'navigation_screen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _NavigationScreen createState() => _NavigationScreen();
}

class _NavigationScreen extends State<NavigationScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  Position currentPosition;
  static LatLng initialPosition;

//  void initState() async{
//    super.initState();
//
//    getUserLocation();
//  }

  void getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latlangposition = LatLng(position.latitude,position.longitude);
    print(latlangposition.longitude);
    initialPosition = latlangposition;
    //ameraPosition cameraPosition = new CameraPosition(target:latlangposition,zoom: 14);
    //newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    //return latlangposition;
  }
  static final CameraPosition _kGooglePlex = CameraPosition(
    target:LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Navigation'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,

//            initialCameraPosition: CameraPosition(
//              target: _kGooglePlex,
//              zoom: 14,
//            ),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller)
            {

              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {

              });

            },
          ),
        ],


      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}