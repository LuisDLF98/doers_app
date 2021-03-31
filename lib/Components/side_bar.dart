import 'package:doers_app/Screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/payment_screen.dart';
import 'package:doers_app/Screens/welcome_screen.dart';
import 'package:doers_app/Components/Authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:doers_app/Screens/my_jobs_screen.dart';


class NavDrawer extends StatelessWidget {
  NavDrawer({Key key, this.userData}) : super(key: key);
  final List<String> userData;
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
            onTap: () => {Navigator.pushNamed(context, ProfileScreen.id, arguments: {'userInfo': userData})},
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
            leading: Icon(Icons.settings),
            title: Text('My Jobs'),
            onTap: () => {Navigator.pushNamed(context, MyJobsScreen.id)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await signOutGoogle();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}