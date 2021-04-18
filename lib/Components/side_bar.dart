import 'package:doers_app/Screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/welcome_screen.dart';
import 'package:doers_app/Components/Authentication.dart';
import 'package:doers_app/Screens/my_jobs_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
            onTap: () async {
              Map<String, dynamic> arguments = {};
              DocumentReference ref = FirebaseFirestore.instance.collection('Users').doc(userData[0]);
              DocumentSnapshot snap = await ref.get();

              Map<String, dynamic> data = snap.data();
              arguments['ID'] = userData[0];
              arguments['name'] = data['firstName'] + ' ' + data['lastName'];
              arguments['email'] = data['email'];
              arguments['image'] = data['profileImage'];

              // Get ratings average
              int count = 0;
              int total = 0;
              Query query = FirebaseFirestore.instance
                  .collection('Reviews')
                  .where('recipient', isEqualTo: userData[0]);
              await query.get().then((querySnapshot) => {
                for (DocumentSnapshot doc in querySnapshot.docs)
                  {
                    total = total + doc['rating'].toInt(),
                    count = count + 1
                  }
              });
              double avg = total / count;
              if ((avg == double.nan) || avg.isNaN) {
                arguments['rating'] = 0.0;
              }
              else {
                arguments['rating'] = avg;
              }

              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProfileScreen(args: arguments)
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.pushNamed(context, SettingsScreen.id, arguments: {'userInfo': userData})},
          ),
          ListTile(
            leading: Icon(Icons.cases),
            title: Text('My Jobs'),
            onTap: () => {Navigator.pushNamed(context, MyJobsScreen.id, arguments: {'userInfo': userData})},
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