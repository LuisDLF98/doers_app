import 'package:flutter/material.dart';
import 'package:doers_app/Screens/home_screen.dart';
import 'package:doers_app/Screens/messaging_screen.dart';
import 'package:doers_app/Screens/navigation_screen.dart';
import 'package:doers_app/Screens/details_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.userData}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final List<String> userData;

  @override
  _MyHomePageState createState() => _MyHomePageState(userData);
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentTab = 0;
  int pageNum = 0;
  List<String> loginInfo;

  _MyHomePageState(this.loginInfo);

  void _selectTab(int tab) {
    setState(() {
      _currentTab = tab;
      pageNum = tab;
    });
  }




  Widget _getFAB() {
    if (pageNum == 1) {
      return Container();
    } else {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, DetailsScreen.id);
        },
        tooltip: 'Add Job',
        child: Icon(Icons.add),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Messaging',
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            label: 'Navigation',
            icon: Icon(Icons.location_pin),
          ),
        ],
        currentIndex: _currentTab,
        onTap: _selectTab,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: IndexedStack(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          index: pageNum,
          children: [
            HomeScreen(userData: loginInfo),
            MessagingScreen(userData: loginInfo),
            NavigationScreen(userData: loginInfo),
          ],
        ),
      ),

      floatingActionButton: _getFAB(),
    );
  }
}