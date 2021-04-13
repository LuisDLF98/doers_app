import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Screens/reviews_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/barchart_simple.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/Authentication.dart';
import 'package:doers_app/Screens/welcome_screen.dart';
import 'package:doers_app/Screens/profile_reviews_screen.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.args}) : super(key: key);
  static const String id = 'profile_screen';
  Map args;


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ProfileScreen createState() => _ProfileScreen(args);
}

/*
    TODO: See below idea
    Update Profile page with new info
      Make users anonymous by not showing IDs of reviewers
    Ratings/Reviews button - click
      Display list of reviews/ratings associated
      Click on individual review or make card big enough to fit the review
        Display individual review
      Average Star# together to obtain overall rating
 */

class _ProfileScreen extends State<ProfileScreen> {
  _ProfileScreen(this.args);
  Map args;

  // TODO: Guide - 'ID' = db ID, 'name' = First + Last name, 'email' = email, 'image' = Profile image


  @override
  Widget build(BuildContext context) {
    //final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 53),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            //verticalDirection
            //mainAxisAlignment: mainaxisalignment.center start .spaceEvenely , space between
            children: <Widget>[
              CircleAvatar(
                radius: 90.0,
                backgroundImage: NetworkImage(
                    args['image']),
              ),
              Text(
                args['name'],
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                args['email'],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Rating:  5.0 \u{2B50}\u{2B50}\u{2B50}\u{2B50}\u{2B50}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RoundedButton(
                title: 'See Reviews',
                colour: color[100],
                font_size: 17,
                text_color: color[600],
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileReviewsScreen(argmts: args)
                  ));
                },
              ),
              SizedBox(
                height: 100,
              ),
              /*
              OutlinedButton(
                child: Text(
                  'Logout',
                  style: TextStyle(
                  color: color[300],
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                ),
                onPressed: () async {
                  await signOutGoogle();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
              ), */
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
