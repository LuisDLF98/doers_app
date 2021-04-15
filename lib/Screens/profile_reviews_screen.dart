import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/review_details_screen.dart';

class ProfileReviewsScreen extends StatefulWidget {
  ProfileReviewsScreen({Key key, this.argmts}) : super(key: key);
  static const String id = 'profile_reviews_screen';
  Map argmts;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ProfileReviewsScreen createState() => _ProfileReviewsScreen(argmts);
}

class _ProfileReviewsScreen extends State<ProfileReviewsScreen> {
  _ProfileReviewsScreen(this.argmts);
  Map argmts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Reviews'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Reviews')
              .where('recipient', isEqualTo: argmts['ID'])
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data.docs.length == 0) {
              return Center(
                child: Text('There are currently no reviews for this user'),
              );
            } else {
              return new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Container(
                    height: 696,
                    alignment: AlignmentDirectional(20.0, 0.0),
                    child: Expanded(
                      child: ListView(
                        children: snapshot.data.docs.map<Widget>((document) {
                          return Card(
                              child: ListTile(
                                  leading: Icon(
                                    Icons.article_rounded,
                                    color: color[100],
                                  ),
                                  title: Row(children: <Widget>[
                                    Text(document['jobType'] + ' '),
                                    RatingBarIndicator(
                                      rating: document['rating'].toDouble(),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 25.0,
                                      direction: Axis.horizontal,
                                    )
                                  ]),
                                  subtitle: new Text(document['review']),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ReviewDetailsScreen.id,
                                        arguments: {'ReviewID': document.id});
                                  }));
                        }).toList(),
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
