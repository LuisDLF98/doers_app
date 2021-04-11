import 'package:doers_app/Screens/reviews_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/barchart_simple.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/Authentication.dart';
import 'package:doers_app/Screens/welcome_screen.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);
  static const String id = 'profile_screen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

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
                    arguments['userInfo'][3]),
              ),
              Text(
                arguments['userInfo'][1],
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                arguments['userInfo'][2],
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
                title: 'My Reviews',
                colour: color[100],
                font_size: 17,
                text_color: color[600],
                onPressed: () {
                  Navigator.pushNamed(context, ReviewsScreen.id);
                },
              ),
              SizedBox(
                height: 180,
              ),
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
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
