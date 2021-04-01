import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Screens/job_details_screen.dart';

class MyJobsScreen extends StatefulWidget {
  MyJobsScreen({Key key}) : super(key: key);
  static const String id = 'my_jobs_screen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyJobsScreen createState() => _MyJobsScreen();
}


class _MyJobsScreen extends State<MyJobsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('My Jobs'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Task Listings').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                new SizedBox(
                    height: 60,
                    child: Column(
                        children: <Widget>[
                          ButtonBar(
                              alignment: MainAxisAlignment.center,

                              children: <Widget> [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: color[100],
                                    backgroundColor: color[300],
                                  ),
                                  child: Text('Jobs Requested'),
                                  onPressed: () {  },
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: color[100],
                                    backgroundColor: color[300],
                                  ),
                                  child: Text('Jobs Done'),
                                  onPressed: () {  },
                                ),
                              ]
                          ),
                        ]
                    )
                ),
                new Container(
                  height: 696,
                  alignment: AlignmentDirectional(20.0,0.0),
                  child: Expanded(
                    child: ListView(
                      children: snapshot.data.docs.map<Widget>((document) {
                        return Card(
                            child: ListTile(
                                leading: Icon(
                                  Icons.map,
                                  color: color[100],
                                ),
                                title: new Text(document['jobType']),
                                subtitle: new Text(document['description']),
                                onTap: () {
                                  Navigator.pushNamed(context, JobDetailScreen.id,
                                      arguments: {'JobID': document.id});
                                }
                            )
                        );
                      }).toList(),
                    ),
                  ),
                )

              ],
            );

          }
      ),
    );

  }

}





