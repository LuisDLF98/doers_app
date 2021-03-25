import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';

class JobDetailScreen extends StatefulWidget {
  JobDetailScreen({Key key, this.title}) : super(key: key);
  static const String id = 'job_details_screen';
  //TODO:: Add the variables to import from the specific job
  final String title;
  DateTime selectedDate = DateTime.now();
  @override
  _JobDetailScreen createState() => _JobDetailScreen();
}

class _JobDetailScreen extends State<JobDetailScreen>{
  @override
  Widget build(BuildContext context){

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final firestoreInstance = FirebaseFirestore.instance;
    CollectionReference tasks = firestoreInstance.collection('Task Listings');
    return FutureBuilder<DocumentSnapshot>(
        future: tasks.doc(arguments['JobID']).get(),
        builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError){
            return Text("Something went wrong");
          }

          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data.data();
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 150.0,
                  backgroundColor: color[500],
                  flexibleSpace:
                   FlexibleSpaceBar(
                    title: Text("${data['jobType']}"),
                  ),
                )
              ]
            );
           // return Text("Job Type, Then descrpition: ${data['jobType']} ${data['description']}");
          }
          return Text("failed");
        }
    );

    return MaterialApp(
        home:Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            backgroundColor: color[100],
            title: Text("Job Details Page"),
          ),
          body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 150.0,
                  backgroundColor: color[500],
                  flexibleSpace:
                  const FlexibleSpaceBar(
                    title:Text("Mowing A lawn"),
                  ),

                ),
                SliverToBoxAdapter(
                    child: Center(
                        child: SizedBox(
                            height: 80,
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
                                          child: Text('Message'),
                                          onPressed: () {  },
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            primary: color[100],
                                            backgroundColor: color[300],
                                          ),
                                          child: Text('Accept'),
                                          onPressed: () {  },
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            primary: color[100],
                                            backgroundColor: color[300],
                                          ),
                                          child: Text('Navigate'),
                                          onPressed: () {  },
                                        ),
                                      ]
                                  ),
                                ]
                            )
                        )
                    )

                ),

                SliverToBoxAdapter(
                    child: Center(
                        child: SizedBox(
                            height: 300,
                            child: ListView(
                                children: <Widget>[
                                  Card(
                                      child:ListTile(
                                        leading: Icon(
                                          Icons.work_off_outlined,
                                          color: color[100],
                                        ),
                                        title: Text("Type of job"),

                                      )
                                  ),
                                  Card(
                                      child:ListTile(
                                        leading: Icon(
                                          Icons.lock_clock,
                                          color: color[100],
                                        ),
                                        title: Text("Time begin"),

                                      )
                                  ),
                                  Card(
                                      child:ListTile(
                                        leading: Icon(
                                          Icons.lock_clock,
                                          color: color[100],
                                        ),
                                        title: Text("Estimated Duration"),

                                      )
                                  ),
                                  Card(
                                      child:ListTile(
                                        leading: Icon(
                                          Icons.map_rounded,
                                          color: color[100],
                                        ),
                                        title: Text("1305 Milner Dr College Station, Tx, 77840"),

                                      )
                                  )
                                ]
                            )
                        )
                    )

                ),


              ]
          ),
        )
    );

  }

}