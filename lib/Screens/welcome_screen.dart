import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'registration_form_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:doers_app/Components/Authentication.dart';
import 'my_home_page_screen.dart';
import 'package:doers_app/globals.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

//  bool nightMode;
//  WelcomeScreen({Key key, this.nightMode}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

//  bool nightMode;
//  _WelcomeScreenState(this.nightMode);

  AnimationController controller;
  Animation animation;
  var c;
  var ct;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 2), vsync: this, upperBound: 1.0);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    if(nightMode){
      c = color[600];
      ct = color[300];
    }
    else{
      c = color[550];
      ct = color[700];
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/DoersV3.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Doers'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: ct,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: color[200],
              font_size: 17,
              text_color: color[300],
              onPressed: () async {
                signOutGoogle(); // Ensure user is signed out before attempting to sign in
                List<String> signIn = await signInWithGoogle();
                if (signIn != null && signIn.length == 5) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(userData: signIn)),
                  );
                }
                else if (signIn == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select an account!')));
                } else if (signIn.first == "Not Registered!") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please register first to access the app!')));
                }
                else {
                  print('Something seriously bad happened');
                }
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: color[200],
              font_size: 17,
              text_color: color[300],
              onPressed: () {
                Navigator.pushNamed(context, RegistrationFormScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
