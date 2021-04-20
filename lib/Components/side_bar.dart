import 'package:doers_app/Screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/welcome_screen.dart';
import 'package:doers_app/Components/Authentication.dart';
import 'package:doers_app/Screens/my_jobs_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/globals.dart';
import 'hex_colors.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({Key key, this.userData}) : super(key: key);
  final List<String> userData;

  @override
  _NavDrawer createState() => _NavDrawer(userData);
}

class _NavDrawer extends State<NavDrawer> {
  _NavDrawer(this.userData);
  final List<String> userData;

  var cb;
  var ct;
  var titleC;
  var ic;

  void initState() {
    super.initState();

    void tryme() {
      print("hey");
    }

    if (nightMode) {
      cb = color[650];
      ct = color[300];
      titleC = color[600];
      ic = color[300];
    } else {
      cb = color[300];
      ct = color[700];
      titleC = color[300];
      ic = color[200];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: cb,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: titleC,
              child: DrawerHeader(
                child: Text(
                  'Side Menu',
                  style: TextStyle(color: ct),
                ),
              ),
            ),
            ListTile(
              //tileColor: tileC,
              leading: Icon(Icons.person, color: ic),
              title: Text('Profile', style: TextStyle(color: ct)),
              onTap: () async {
                Map<String, dynamic> arguments = {};
                DocumentReference ref = FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userData[0]);
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
                } else {
                  arguments['rating'] = avg;
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(args: arguments)));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: ic),
              title: Text('Settings', style: TextStyle(color: ct)),
              onTap: () => {
                Navigator.pushNamed(context, SettingsScreen.id,
                        arguments: {'userInfo': userData})
                    .then((value) => setState(() {
                          // refresh state of Page1
                          if (nightMode) {
                            //print(nightMode);
                            cb = color[650];
                            titleC = color[600];
                            ct = color[300];
                            ic = color[300];
                          } else {
                            titleC = color[300];
                            cb = color[300];
                            ic = color[200];
                            ct = color[700];
                          }
                        }))
              },
            ),
            ListTile(
              leading: Icon(Icons.cases, color: ic),
              title: Text('My Jobs', style: TextStyle(color: ct)),
              onTap: () => {
                Navigator.pushNamed(context, MyJobsScreen.id,
                    arguments: {'userInfo': userData})
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: ic),
              title: Text('Logout', style: TextStyle(color: ct)),
              onTap: () async {
                await signOutGoogle();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
