import 'dart:math';
import 'package:doers_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Screens/job_details_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.userData}) : super(key: key);
  static const String id = 'home_screen';
  final List<String> userData;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomeScreen createState() => _HomeScreen(userData);
}

class _HomeScreen extends State<HomeScreen> {
  List<String> loginInfo;
  _HomeScreen(this.loginInfo);

  @override
  Widget build(BuildContext context) {
    List<Card> test = [];
    List<bool> test2 = [];

    return Scaffold(
      drawer: NavDrawer(userData: loginInfo),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Task Listings').where('ownedBy', isNotEqualTo: loginInfo[0]).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            snapshot.data.docs.forEach((document) {
              Timestamp time = document['date'];
              DateTime dateTime = time.toDate();
              test.add(Card(
                  child: ListTile(
                      leading: jobCategoryIcon[document['jobType']],

                      title: new Text(document['jobType']),
                      subtitle: new Text(document['description']),
                      trailing: Text("${DateFormat.jm().format(dateTime)}"),
                      // trailing: new Text(document['date']),
                      onTap: (){
                        Navigator.pushNamed(context, JobDetailScreen.id, arguments: {'JobID': document.id, 'userInfo': loginInfo});
                      }
                  )
              ));
              test2.add(document['isCompleted']);
            });

            List<Card> actual = [];
            for(int i = 0; i < test.length; i++) {
              if (!test2[i]) {
                actual.add(test[i]);
              }
            }

            return new ListView(
              children: actual
            );

            /*return new ListView(
             children: snapshot.data.docs.map<Widget>((document) {
                 return Card(
                   child: ListTile(
                     leading: Icon(
                       Icons.map,
                       color: color[100],
                     ),
                     title: new Text(document['jobType']),
                     subtitle: new Text(document['description']),
                    // trailing: new Text(document['date']),
                       onTap: (){
                         Navigator.pushNamed(context, JobDetailScreen.id, arguments: {'JobID': document.id, 'userInfo': loginInfo});
                       }
                   )
                 );
             }).toList()
            );*/
          }
      ),
    );

  }
}