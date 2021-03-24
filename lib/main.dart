import 'package:doers_app/Screens/details_screen.dart';
import 'package:doers_app/Screens/registration_form_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Screens/welcome_screen.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:doers_app/Screens/home_screen.dart';
import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/settings_screen.dart';
import 'package:doers_app/Screens/payment_screen.dart';
import 'package:doers_app/Screens/messaging_screen.dart';
import 'package:doers_app/Screens/navigation_screen.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/screens/job_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: color[100],
          accentColor: color[50],
          backgroundColor: color[500],
          scaffoldBackgroundColor: color[500],
          cardColor: color[300],
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          //LoginScreen.id: (context) => LoginScreen(),
          //RegistrationScreen.id: (context) => RegistrationScreen(),
          RegistrationFormScreen.id: (context) => RegistrationFormScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          MessagingScreen.id: (context) => MessagingScreen(),
          PaymentsScreen.id: (context) => PaymentsScreen(),
          NavigationScreen.id: (context) => NavigationScreen(),
          DetailsScreen.id: (context) => DetailsScreen(),
          JobDetailScreen.id: (context) => JobDetailScreen(),
          //ChatScreen.id: (context) => ChatScreen(),
        }
    );
  }
}

