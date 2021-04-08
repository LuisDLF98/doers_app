import 'dart:async';

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

// Function that automates the building of Card objects with info from the database
ListTile populateJob(
    String jobType, String description, String jobID, BuildContext context, List<String> userInfo) {
  return ListTile(
      leading: Icon(Icons.map, color: color[100]),
      title: new Text(jobType),
      subtitle: new Text(description),
      onTap: () {
        Navigator.pushNamed(context, JobDetailScreen.id,
            arguments: {'JobID': jobID, 'userInfo': userInfo});
      });
}

Future<List<ListTile>> loadJobs(
    int index, List<String> userInfo, BuildContext context) async {
// Figure out what list to add jobs to based on 'ownedBy', 'doerAssigned', and 'isCompleted' fields
  List<List<ListTile>> jobs = [[], [], [], []];
  CollectionReference tasks =
      FirebaseFirestore.instance.collection('Task Listings');
  QuerySnapshot snapshot = await tasks.get();
  snapshot.docs.forEach((document) {
    print(document.toString());
    String ownedBy = document.data()['ownedBy'];
    String doerAssigned = document.data()['doerAssigned'];
    bool isCompleted = document.data()['isCompleted'];
    if (index == 0 && ownedBy == userInfo[0] && isCompleted == false) {
      jobs[0].add(populateJob(
          document['jobType'], document['description'], document.id, context, userInfo));
    } else if (index == 1 && ownedBy == userInfo[0] && isCompleted == true) {
      jobs[1].add(populateJob(
          document['jobType'], document['description'], document.id, context, userInfo));
    } else if (index == 2 && doerAssigned == userInfo[0] && isCompleted == false) {
      jobs[2].add(populateJob(
          document['jobType'], document['description'], document.id, context, userInfo));
    } else if (index == 3 && doerAssigned == userInfo[0] && isCompleted == true) {
      jobs[3].add(populateJob(
          document['jobType'], document['description'], document.id, context, userInfo));
    }
  });
  return jobs[index];
}

class _MyJobsScreen extends State<MyJobsScreen> {
  // This variable keeps track of what list to show the user based on the four choices presented
  final List<ListTile> currentList = [];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    // Figure out what list to add jobs to based on 'ownedBy', 'doerAssigned', and 'isCompleted' fields
    List<ListTile> requestedJobs = [];
    List<ListTile> doneJobs = [];
    List<ListTile> inProgressJobs = [];
    List<ListTile> completedJobs = [];

    currentList.add(ListTile(
      leading: Icon(Icons.info, color: color[100]),
      title: new Text(''),
      subtitle: new Text('Click one of the buttons above to load your jobs!'),
    ));

    return Scaffold(
        //drawer: NavDrawer(),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('My Jobs'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            new SizedBox(
                height: 120,
                child: Column(children: <Widget>[
                  ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: color[100],
                                    backgroundColor: color[300],
                                  ),
                                  child: Text('Requested'),
                                  onPressed: () async {
                                    requestedJobs = await loadJobs(
                                        0, arguments['userInfo'], context);
                                    print('requested');
                                    setState(() {
                                      while (currentList.isNotEmpty) {
                                        currentList.removeLast();
                                      }
                                      requestedJobs.forEach((card) {
                                        //jobs.add(card);
                                        currentList.add(card);
                                      });
                                      print(currentList);
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: color[100],
                                    backgroundColor: color[300],
                                  ),
                                  child: Text('Done'),
                                  onPressed: () async {
                                    doneJobs = await loadJobs(
                                        1, arguments['userInfo'], context);
                                    print('done');
                                    setState(() {
                                      while (currentList.isNotEmpty) {
                                        currentList.removeLast();
                                      }
                                      doneJobs.forEach((card) {
                                        currentList.add(card);
                                      });
                                      print(currentList);
                                    });
                                  },
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: color[100],
                                    backgroundColor: color[300],
                                  ),
                                  child: Text('In Progress'),
                                  onPressed: () async {
                                    inProgressJobs = await loadJobs(
                                        2, arguments['userInfo'], context);
                                    print('in progress');
                                    setState(() {
                                      while (currentList.isNotEmpty) {
                                        currentList.removeLast();
                                      }
                                      inProgressJobs.forEach((card) {
                                        currentList.add(card);
                                      });
                                      print(currentList);
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: color[100],
                                    backgroundColor: color[300],
                                  ),
                                  child: Text('Completed'),
                                  onPressed: () async {
                                    completedJobs = await loadJobs(
                                        3, arguments['userInfo'], context);
                                    print('completed');
                                    setState(() {
                                      while (currentList.isNotEmpty) {
                                        currentList.removeLast();
                                      }
                                      completedJobs.forEach((card) {
                                        currentList.add(card);
                                      });
                                      print(currentList);
                                    });
                                  },
                                ),
                              )
                            ]),
                      ]),
                ])),
            new Expanded(
                child: ListView.builder(
                    itemCount: currentList.length,
                    itemBuilder: (context, idx) {
                      if(idx == currentList.length-1 && currentList.length != 1) {
                        return null;
                      }
                      return Card(
                        key: UniqueKey(),
                        child: currentList[idx],
                      );
                    })
                )
          ],
        ));
  }
}
