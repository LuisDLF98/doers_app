import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:intl/intl.dart';
import 'package:doers_app/constants.dart';

class ReviewsScreen extends StatefulWidget {
  ReviewsScreen({Key key, this.reviewer, this.jobID}) : super(key: key);
  static const String id = 'reviews_screen';
  String reviewer;
  String jobID;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ReviewsScreen createState() => _ReviewsScreen(reviewer, jobID);
}

class _ReviewsScreen extends State<ReviewsScreen> {
  _ReviewsScreen(this.reviewer, this.jobID);
  String reviewer;
  String jobID;


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    String review;
    int rating;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Leave A Review'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                onChanged: (value) {
                  //Do something with the user input.
                  review = value;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.article),
                  hintText: 'Enter your review here',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color[50], width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color[100], width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please give a review!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  //Do something with the user input.
                  rating = int.parse(value);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.star),
                  hintText: '# of Stars',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color[50], width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color[100], width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                validator: (value) {
                  int valueInt = 0;
                  if (!value.isEmpty) {
                    valueInt = int.parse(value);
                  }
                  if (valueInt < 1 || valueInt > 5) {
                    return "Please input a rating between 1-5";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25),
                child: RoundedButton(
                  colour: color[200],
                  title: 'Submit',
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Review submitted!')));
                      final firestoreInstance = FirebaseFirestore.instance;
                      DocumentReference ref = firestoreInstance.collection('Task Listings').doc(jobID);
                      String jobType;
                      String doerAssigned;
                      String owner;

                      await ref.get().then((snapshot) {
                        jobType = snapshot.data()['jobType'];
                        doerAssigned = snapshot.data()['doerAssigned'];
                        owner = snapshot.data()['ownedBy'];
                      });

                      bool isDoer = doerAssigned == reviewer;
                      String recipient;
                      if (isDoer) {
                        recipient = owner;
                      }
                      else {
                        recipient = doerAssigned;
                      }

                      DocumentReference docRef =
                          await firestoreInstance.collection('Reviews').add({
                        "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
                        "isDoer": isDoer,
                        "jobID": jobID,
                        "jobType": jobType,
                        "rating": rating,
                        "recipient": recipient,
                        "review": review,
                        "reviewer": reviewer
                      });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Information still needed!')));
                    }
                  }, // onPressed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
