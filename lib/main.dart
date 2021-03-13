import 'package:doers_app/screens/registration_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/screens/welcome_screen.dart';
import 'package:doers_app/screens/login_screen.dart';
import 'package:doers_app/screens/registration_screen.dart';


void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        RegistrationFormScreen.id: (context) => RegistrationFormScreen(),
        //ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}