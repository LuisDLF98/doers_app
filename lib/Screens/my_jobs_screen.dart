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
Card populateJob(String jobType, String description, String jobID, BuildContext context) {
  return Card(
    child: ListTile(
        leading: Icon(
            Icons.map,
            color: color[100]
        ),
        title: new Text(jobType),
        subtitle: new Text(description),
        onTap: () {
          Navigator.pushNamed(context, JobDetailScreen.id,
              arguments: {'JobID': jobID});
        }
    ),
  );
}

class _MyJobsScreen extends State<MyJobsScreen> {

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    List<Card> requestedJobs = [];
    List<Card> doneJobs = [];
    List<Card> inProgressJobs = [];
    List<Card> completedJobs = [];

    // Figure out what list to add jobs to based on 'ownedBy', 'doerAssigned', and 'isCompleted' fields
    Stream<QuerySnapshot> tasks = FirebaseFirestore.instance.collection('Task Listings').snapshots();
    tasks.forEach((snapshot) {
      // TODO: Program currently throws error b/c 'field does not exist'
      // Probably b/c of async issues...
      snapshot.docs.forEach((document) {
        print(document.toString());
        if(document['ownedBy'] == arguments['userInfo'][0] && document['isCompleted'] == false) {
          requestedJobs.add(
              populateJob(document['jobType'], document['description'], document.id, context)
          );
        }
        else if(document['ownedBy'] == arguments['userInfo'][0] && document['isCompleted'] == true) {
          doneJobs.add(
              populateJob(document['jobType'], document['description'], document.id, context)
          );
        }
        else if(document['doerAssigned'] == arguments['userInfo'][0] && document['isCompleted'] == false) {
          inProgressJobs.add(
              populateJob(document['jobType'], document['description'], document.id, context)
          );
        }
        else if (document['doerAssigned'] == arguments['userInfo'][0] && document['isCompleted'] == true) {
          completedJobs.add(
              populateJob(document['jobType'], document['description'], document.id, context)
          );
        }
      });
    });

    // This variable keeps track of what list to show the user based on the four choices presented
    List<Card> currentList = requestedJobs;

    return Scaffold(
      //drawer: NavDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('My Jobs'),
      ),
      body: StreamBuilder(
          stream: tasks,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              return new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,

                children: [
                  new SizedBox(
                      height: 120,
                      child: Column(
                          children: <Widget>[
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
                                          onPressed: () {
                                            setState(() {
                                              print('requested');
                                              currentList = requestedJobs;
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
                                          onPressed: () {
                                            setState(() {
                                              print('done');
                                              currentList = doneJobs;
                                              print(currentList);
                                            });
                                          },
                                        ),
                                      ),
                                    ]
                                  ),
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
                                          onPressed: () {
                                            setState(() {
                                              print('in progress');
                                              currentList = inProgressJobs;
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
                                          onPressed: () {
                                            setState(() {
                                              print('completed');
                                              currentList = completedJobs;
                                              print(currentList);
                                            });
                                          },
                                        ),
                                      )
                                    ]
                                  ),
                                ]
                            ),
                          ]
                      )
                  ),
                  new Container(
                    height: 696,
                    alignment: AlignmentDirectional(20.0, 0.0),
                    child: Expanded(

                      // TODO: Change this to use one of the four lists created earlier - below code might work
                      child: ListView(
                        children: currentList,
                      ),

                      /*child: ListView(
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
                                    Navigator.pushNamed(
                                        context, JobDetailScreen.id,
                                        arguments: {'JobID': document.id});
                                  }
                              )
                          );
                        }).toList(),
                      ),*/
                    ),
                  )

                ],
              );
            }
          }
      ),
    );

  }

}





