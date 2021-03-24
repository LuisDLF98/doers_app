import 'package:doers_app/Screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/payment_screen.dart';
import 'package:doers_app/Screens/welcome_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/userinfo.email',
  ],
);

Future<void> _handleSignOut() => _googleSignIn.disconnect();

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side Menu',
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => {Navigator.pushNamed(context, ProfileScreen.id)},
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Payments'),
            onTap: () => {Navigator.pushNamed(context, PaymentsScreen.id)},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.pushNamed(context, SettingsScreen.id)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              _handleSignOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}