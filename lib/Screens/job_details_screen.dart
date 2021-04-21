import 'package:doers_app/Screens/navigation_screen.dart';
import 'package:doers_app/Screens/conversation_screen.dart';
import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Screens/conversations_screen.dart';
import 'package:intl/intl.dart';
import 'package:doers_app/globals.dart';

class JobDetailScreen extends StatefulWidget {
  JobDetailScreen({Key key, this.title}) : super(key: key);
  static const String id = 'job_details_screen';
  //TODO:: Add the variables to import from the specific job
  final String title;
  DateTime selectedDate = DateTime.now();
  @override
  _JobDetailScreen createState() => _JobDetailScreen();
}

class _JobDetailScreen extends State<JobDetailScreen> {
  var cb;
  var cardC;
  var ct;
  var ac;
  var sc;
  void initState() {
    super.initState();

    if(nightMode){
      cb = color[600];
      cardC = color[650];
      ct = color[300];
      ac = color[300];
      sc = color[100];
    }
    else{
      cb = color[400];
      cardC = color[300];
      ct = color[700];
      ac = color[600];
      sc = color[500];
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final firestoreInstance = FirebaseFirestore.instance;
    CollectionReference tasks = firestoreInstance.collection('Task Listings');
    CollectionReference convos = firestoreInstance.collection('Conversations');
    CollectionReference users = firestoreInstance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
        future: tasks.doc(arguments['JobID']).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("Something went wrong", style: TextStyle(color: ct));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            bool ownerView = (arguments['userInfo'][0] == data['ownedBy']);
            bool doerView = (arguments['userInfo'][0] == data['doerAssigned']);
            Timestamp time = data['date'];
            DateTime dateTime = time.toDate();
            Timestamp end = data['timeRange'];
            DateTime endTime = end.toDate();

            return Container(
              color: cardC,
              child: CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 150.0,
                  backgroundColor: sc,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("${data['jobType']}"),
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
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              primary: color[200],
                                              backgroundColor: cardC,
                                            ),
                                            child: Text('Message'),
                                            onPressed: () async {
                                              var arr = [
                                                arguments['userInfo'][0],
                                                "${data['ownedBy']}"
                                              ];
                                              var arr2 = [
                                                "${data['ownedBy']}",
                                                arguments['userInfo'][0]
                                              ];
                                              var result =
                                                  await firestoreInstance
                                                      .collection(
                                                          "Conversations")
                                                      .where("users",
                                                          isEqualTo: arr)
                                                      .limit(1)
                                                      .get();

                                              var resultFlipped =
                                                  await firestoreInstance
                                                      .collection(
                                                          "Conversations")
                                                      .where("users",
                                                          isEqualTo: arr2)
                                                      .limit(1)
                                                      .get();

                                              if (result.size == 1) {
                                                final List<String> myList =
                                                    new List<String>.from({
                                                  arguments['userInfo'][0],
                                                  "${data['ownedBy']}",
                                                  result.docs.first.id,
                                                  arguments['userInfo'][1]
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ConversationDetailPage(
                                                              data: myList)),
                                                );
                                              } else {
                                                if (resultFlipped.size == 1) {
                                                  final List<String> myList =
                                                      new List<String>.from({
                                                    arguments['userInfo'][0],
                                                    "${data['ownedBy']}",
                                                    resultFlipped.docs.first.id,
                                                    arguments['userInfo'][1]
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ConversationDetailPage(
                                                                data: myList)),
                                                  );
                                                } else {
                                                  DocumentReference
                                                      newConversation =
                                                      await convos.add({
                                                    "lastMessage": {
                                                      "content": "",
                                                      "idFrom": "",
                                                      "idTo": "",
                                                      "read": false,
                                                      "timestamp": DateTime
                                                              .now()
                                                          .microsecondsSinceEpoch,
                                                    },
                                                    "users":
                                                        FieldValue.arrayUnion([
                                                      arguments['userInfo'][0],
                                                      "${data['ownedBy']}"
                                                    ])
                                                  });

                                                  Future.delayed(const Duration(
                                                      milliseconds: 250));

                                                  DocumentReference
                                                      firstMessage =
                                                      await newConversation
                                                          .collection(
                                                              "Messages")
                                                          .add({
                                                    "content": "hello",
                                                    "idFrom":
                                                        arguments['userInfo']
                                                            [0],
                                                    "idTo":
                                                        "${data['ownedBy']}",
                                                    "read": false,
                                                    "timestamp": DateTime.now()
                                                        .microsecondsSinceEpoch
                                                  });

                                                  firstMessage
                                                      .get()
                                                      .then((value) {
                                                    newConversation.update({
                                                      "lastMessage": {
                                                        "content": value
                                                            .data()["content"],
                                                        "idFrom": value
                                                            .data()["idFrom"],
                                                        "idTo": value
                                                            .data()["idTo"],
                                                        "read": value
                                                            .data()["read"],
                                                        "timestamp":
                                                            value.data()[
                                                                "timestamp"],
                                                      },
                                                    });
                                                  });

                                                  final List<String> myList =
                                                      new List<String>.from({
                                                    arguments['userInfo'][0],
                                                    "${data['ownedBy']}",
                                                    newConversation.id,
                                                    arguments['userInfo'][1]
                                                  });

                                                  //Navigator.pushNamed(context, MessagingScreen.id);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ConversationDetailPage(
                                                                data: myList)),
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              primary: color[200],
                                              backgroundColor: cardC,
                                            ),
                                            child: Text('Profile'),
                                            onPressed: () async {
                                              Map<String, dynamic> arguments = {};
                                              DocumentReference ref =
                                                  FirebaseFirestore.instance.collection('Users').doc(data['ownedBy']);
                                              DocumentSnapshot snap = await ref.get();

                                              Map<String, dynamic> snapData = snap.data();
                                              arguments['ID'] = snapData['ownedBy'];
                                              arguments['name'] = snapData['firstName'] + ' ' + snapData['lastName'];
                                              arguments['email'] = snapData['email'];
                                              arguments['image'] = snapData['profileImage'];

                                              // Get ratings average
                                              int count = 0;
                                              int total = 0;
                                              Query query = FirebaseFirestore.instance
                                                  .collection('Reviews')
                                                  .where('recipient', isEqualTo: data['ownedBy']);
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

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ProfileScreen(args: arguments)));
                                            },
                                          ),
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              primary: color[200],
                                              backgroundColor: cardC,
                                            ),
                                            child: Text('Navigate'),
                                            onPressed: () {
                                              String value = data['address'];
                                              //Navigator.pushNamed(context, NavigationScreen.id, arguments: {data['address']});
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NavigationScreen(
                                                              value: value)));
                                            },
                                          ),
                                          Visibility(
                                            visible: (!ownerView &&
                                                !data['isCompleted'] && data['doerAssigned'] == null),
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                primary: color[200],
                                                backgroundColor: cardC,
                                              ),
                                              child: Text('Accept'),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Are you sure you want to accept this task?"),
                                                        actions: <Widget>[
                                                          OutlinedButton(
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  color[200],
                                                              backgroundColor:
                                                              cardC,
                                                            ),
                                                            child:
                                                                Text('Accept', style: TextStyle(color: ct)),
                                                            onPressed: () {
                                                              tasks
                                                                  .doc(arguments[
                                                                      'JobID'])
                                                                  .set(
                                                                      {
                                                                    "doerAssigned":
                                                                        arguments[
                                                                            'userInfo'][0]
                                                                  },
                                                                      SetOptions(
                                                                          merge:
                                                                              true));
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text('Task Accepted!', style: TextStyle(color: ct))));
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                            }, // onPressed()
                                                          ),
                                                          OutlinedButton(
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  color[200],
                                                              backgroundColor:
                                                              cardC,
                                                            ),
                                                            child:
                                                                Text('Cancel', style: TextStyle(color: ct)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Visibility(
                                            visible: (ownerView &&
                                                !data['isCompleted'] && data['doerAssigned'] != null),
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                primary: color[200],
                                                backgroundColor: cardC,
                                              ),
                                              child: Text('Complete', style: TextStyle(color: color[200])),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor: cardC,
                                                        title: Text(
                                                            "Are you sure you want to mark this task as completed?", style: TextStyle(color: ct)),
                                                        actions: <Widget>[
                                                          OutlinedButton(
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  color[200],
                                                              backgroundColor:
                                                              cardC,
                                                            ),
                                                            child: Text(
                                                                'Complete', style: TextStyle(color: color[200])),
                                                            onPressed: () {
                                                              tasks
                                                                  .doc(arguments[
                                                                      'JobID'])
                                                                  .set(
                                                                      {
                                                                    "isCompleted":
                                                                        true
                                                                  },
                                                                      SetOptions(
                                                                          merge:
                                                                              true));
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text('Task Completed!', style: TextStyle(color: color[200]))));
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                            }, // onPressed()
                                                          ),
                                                          OutlinedButton(
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  color[200],
                                                              backgroundColor:
                                                              cardC,
                                                            ),
                                                            child:
                                                                Text('Cancel'),
                                                            onPressed: () {
                                                              //TODO:: Navigate back to og page
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                          Visibility(
                                            visible: ((ownerView && data['doerAssigned'] != null) || doerView) &&
                                                data['isCompleted'],
                                            child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  primary: color[200],
                                                  backgroundColor: cardC,
                                                ),
                                                child: Text('Review'),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  ReviewsScreen(
                                                                    reviewer:
                                                                        arguments['userInfo']
                                                                            [0],
                                                                    jobID: arguments[
                                                                        'JobID'],
                                                                  )));
                                                  // Navigate to Reviews Page, passing in user's ID & job info
                                                }),
                                          ),
                                        ],
                                      ),
                                    ])
                              ],
                            )))),
                SliverToBoxAdapter(
                    child: Center(
                        child: Card(
                          color: cardC,
                            child: ListTile(
                  leading: Icon(
                    Icons.description,
                    color: color[100],
                  ),
                  title: Text("${data['description']}", style: TextStyle(color: ct)),
                )))),
                SliverToBoxAdapter(
                    child: Center(
                        child: Card(
                            color: cardC,
                            child: ListTile(
                  leading: Icon(
                    Icons.streetview,
                    color: color[100],
                  ),
                  title: Text("${data['address']}", style: TextStyle(color: ct)),
                )))),
                SliverToBoxAdapter(
                    child: Center(
                        child: Card(
                            color: cardC,
                            child: ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: color[100],
                  ),
                  title: Text("${data['payment']}", style: TextStyle(color: ct)),
                )))),
                SliverToBoxAdapter(
                    child: Center(
                        child: Card(
                            color: cardC,
                            child: ListTile(
                  leading: Icon(
                    Icons.calendar_today,
                    color: color[100],
                  ),
                  title: Text("${DateFormat.yMMMd().format(dateTime)} from ${DateFormat.jm().format(dateTime)} - ${DateFormat.jm().format(endTime)}", style: TextStyle(color: ct)),
                ))))
              ]),
            );
            // return Text("Job Type, Then descrpition: ${data['jobType']} ${data['description']}");
          }
          return Text("failed", style: TextStyle(color: ct));
        });
  }
}

/*return MaterialApp(
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
    );*/
