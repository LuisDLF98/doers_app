import 'package:flutter/material.dart';
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
          stream: FirebaseFirestore.instance.collection('Reviews').snapshots(),
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
                                title: new Text(document['jobType'] + ' ' + ('\u{2B50}' * document['rating'])),
                                subtitle: new Text(document['review']),
                                onTap: (){
                                  Navigator.pushNamed(context, ReviewDetailsScreen.id, arguments: {'ReviewID': document.id});
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