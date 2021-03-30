
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/barchart_simple.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);
  static const String id = 'profile_screen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          //verticalDirection
          //mainAxisAlignment: mainaxisalignment.center start .spaceEvenely , space between
          children: <Widget>[
            CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage(
                  'images/Rusty.jpeg'), //TODO:: change this to be dependent on user
            ),
            Text(
              'Russell Stout',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'DOER',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal,
                    ),
                    title: Text(
                      '512-484-0547', //TODO:: change this to be dependent on user
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                )),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Stout.r3@gmail.com', //TODO:: change this to be dependent on user
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                )),


            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'Rating:',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: Text(
                    '5.0',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ),
            ),

            Expanded(

              child: Card(

                child: SimpleBarChart.withSampleData(),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
