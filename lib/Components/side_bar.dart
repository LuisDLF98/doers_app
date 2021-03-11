import 'file:///C:/Users/Luis/AndroidStudioProjects/doers_app/lib/Screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Luis/AndroidStudioProjects/doers_app/lib/Screens/profile_screen.dart';
import 'file:///C:/Users/Luis/AndroidStudioProjects/doers_app/lib/Screens/payment_screen.dart';

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
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}