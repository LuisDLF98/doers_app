import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Screens/profile_reviews_screen.dart';
import 'package:doers_app/globals.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.args}) : super(key: key);
  static const String id = 'profile_screen';
  Map args;

  @override
  _ProfileScreen createState() => _ProfileScreen(args);
}

class _ProfileScreen extends State<ProfileScreen> {
  _ProfileScreen(this.args);
  Map args;
  var cb;
  // TODO: Guide - 'ID' = db ID, 'name' = First + Last name, 'email' = email, 'image' = Profile image

  void initState() {
    super.initState();

    if(nightMode){
      cb = color[600];
    }
    else{
      cb = color[400];

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: cb,
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
                backgroundImage: NetworkImage(args['image']),
              ),
              Text(
                args['name'],
                style: TextStyle(
                  fontSize: 35,
                  color: color[300],
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
                  color: color[300],
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: EdgeInsets.only(left: 57),
                child: Row(children: <Widget>[
                  Text(
                    'Rating: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: color[300],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  RatingBarIndicator(
                    rating: double.parse(args['rating'].toString()),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  )
                ]),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileReviewsScreen(argmts: args)));
                },
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
