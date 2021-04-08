import 'dart:async';

import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';

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

  //polyline
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  initState() {
    super.initState();
    //loading = true;
    getUserLocation();
    //print("dest " + value);

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

    final query = value;
    var addresses = await Geocoder.google("AIzaSyCac6e3vO4ib9gR5tMEsJcyiOiiMi1-tD0").findAddressesFromQuery(query);
    var first = addresses.first;
    print("lat  ${first.coordinates.latitude}  long ${first.coordinates.longitude}");

    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print(isLocationServiceEnabled);
    print(lat);

    var start = PointLatLng(lat,lng);
    var end = PointLatLng(first.coordinates.latitude,first.coordinates.longitude);
    var startLatLng = LatLng(lat,lng);
    var endLatLng = LatLng(first.coordinates.latitude,first.coordinates.longitude);
    //var details = await AssistantMethods.obtainPlaceDirectionDetails()
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyCac6e3vO4ib9gR5tMEsJcyiOiiMi1-tD0", start, end );
    //print(result);
    //List<PointLatLng> decodedPolyLinePointsResult = polylinePoints.decodePolyline()

    if(result.points.isNotEmpty){
      print("NOT EMPTY");
      result.points.forEach((PointLatLng pointLatLng){
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    else{
      print("EMPTY");
    }
    setState(() {
      Polyline polyline = Polyline(
        color: Colors.blueAccent,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      polylineSet.add(polyline);
      });

    LatLngBounds latlngBounds;
    if(startLatLng.latitude > endLatLng.latitude && startLatLng.longitude > endLatLng.longitude){
      latlngBounds = LatLngBounds(southwest: endLatLng, northeast: startLatLng);
    }
    else if(startLatLng.longitude > endLatLng.longitude){
      latlngBounds= LatLngBounds(southwest: LatLng(startLatLng.latitude,endLatLng.longitude), northeast: LatLng(endLatLng.latitude, startLatLng.longitude));
    }
    else if(startLatLng.latitude > endLatLng.latitude){
      latlngBounds= LatLngBounds(southwest: LatLng(endLatLng.latitude,startLatLng.longitude), northeast: LatLng(startLatLng.latitude, endLatLng.longitude));
    }
    else{
      latlngBounds = LatLngBounds(southwest: startLatLng, northeast: endLatLng);
    }

    print(latlngBounds);

    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latlngBounds, 70));
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
              polylines: polylineSet,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 13.0,
              ),
              onMapCreated :(GoogleMapController controller){
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;
              }

            ),
        ],


      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}