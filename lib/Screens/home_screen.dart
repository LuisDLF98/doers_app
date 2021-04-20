import 'dart:math';
import 'package:doers_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Screens/job_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:doers_app/globals.dart';

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
  var ct;
  var tc;
  var cb;
  var ts;
  var ic;
  void initState() {
    super.initState();
    if(nightMode){
      cb = color[600];
      ct = color[650];
      tc = color[300];
      ts = color[300];
      ic = color[200];
    }
    else{
      cb = color[500];
      ct = color[300];
      tc = color[700];
      ts = color[700];
      ic = color[200];


    }
  }


@override
  Widget build(BuildContext context) {
    List<Card> base = [];
    List<String> assignedIDs = [];
    List<Card> jobs = [];

    return Scaffold(
      backgroundColor: cb,
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
              base.add(Card(
                  child: ListTile(
                      leading: jobCategoryIcon[document['jobType']],

                      title: new Text(document['jobType']),
                      subtitle: new Text(document['description']),
                      trailing: Text("${DateFormat.MMMd().format(dateTime)}"),
                      // trailing: new Text(document['date']),
                      onTap: (){
                        Navigator.pushNamed(context, JobDetailScreen.id, arguments: {'JobID': document.id, 'userInfo': loginInfo});
                      }
                  )
              ));
              assignedIDs.add(document['doerAssigned']);
            });

            if (jobs.isEmpty) {
              for (int i = 0; i < base.length; i++) {
                if (assignedIDs[i] == null && !jobs.contains(base[i])) {
                  jobs.add(base[i]);
                }
              }
            }

            return new ListView(
              children: jobs
            );

            /*return new ListView(
             children: snapshot.data.docs.map<Widget>((document) {
                 return Card(
                   child: ListTile(
                     tileColor: ct,
                     leading: Icon(
                       Icons.map,
                       color: ic,
                     ),
                     title: new Text(document['jobType'], style: TextStyle(color:tc)),
                     subtitle: new Text(document['description'], style: TextStyle(color:ts)),
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