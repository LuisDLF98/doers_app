import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';

class ReviewDetailsScreen extends StatefulWidget {
  ReviewDetailsScreen({Key key}) : super(key: key);
  static const String id = 'review_details_screen';

  @override
  _ReviewDetailsScreen createState() => _ReviewDetailsScreen();
}

class _ReviewDetailsScreen extends State<ReviewDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final firestoreInstance = FirebaseFirestore.instance;
    CollectionReference reviews = firestoreInstance.collection('Reviews');
    return FutureBuilder<DocumentSnapshot>(
        future: reviews.doc(arguments['ReviewID']).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          else{
            Map<String, dynamic> data = snapshot.data.data();

            return Scaffold(
              appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text('Reviews'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    //verticalDirection
                    //mainAxisAlignment: mainaxisalignment.center start .spaceEvenely , space between
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Job: ' + "${data['jobType']}",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.underline
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Rating: ' + ('\u{2B50}' * data['rating']),
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Review:',
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 450,
                        width: 350,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color[500],
                          border: Border.all(
                              color: Colors.white,
                              width: 3.0),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '"' + "${data['review']}" + '"',
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            );
          }
        }  // builder
    );
  }
}