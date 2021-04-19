import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();

            return Container(
              color: color[500],
              child: CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 150.0,
                  backgroundColor: color[100],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("${data['jobType']}"),
                  ),
                ),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 7,
                )),
                SliverToBoxAdapter(
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Card(
                                color: color[300],
                                child: ListTile(
                                  title: Row(children: <Widget>[
                                    Text(
                                      'Rating: ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: color[600]
                                    )),
                                    RatingBarIndicator(
                                      rating: data['rating'].toDouble(),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 25.0,
                                      direction: Axis.horizontal,
                                    )
                                  ]),
                                ))))),
                SliverFillRemaining(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            decoration: BoxDecoration(
                                color: color[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(10),
                            child: Text('"' + "${data['review']}" + '"',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: color[600],
                                    fontFamily: 'Courier',
                                    fontWeight: FontWeight.w500)),
                          ))),
                ),
              ]),
            );
          }
          return Container(
              color: color[500]);
        } // builder
        );
  }
}
