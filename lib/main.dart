import 'package:doers_app/screens/registration_form_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/screens/welcome_screen.dart';
import 'package:doers_app/screens/login_screen.dart';
import 'package:doers_app/screens/registration_screen.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:doers_app/Screens/home_screen.dart';
import 'package:doers_app/Screens/profile_screen.dart';
import 'package:doers_app/Screens/settings_screen.dart';
import 'package:doers_app/Screens/payment_screen.dart';
import 'package:doers_app/Screens/messaging_screen.dart';
import 'package:doers_app/Screens/navigation_screen.dart';
import 'package:doers_app/Components/hex_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: color[100],
        accentColor: color[50],
        backgroundColor: color[500],
        scaffoldBackgroundColor: color[500],
        cardColor: color[300],
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          RegistrationFormScreen.id: (context) => RegistrationFormScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          MessagingScreen.id: (context) => MessagingScreen(),
          PaymentsScreen.id: (context) => PaymentsScreen(),
          NavigationScreen.id: (context) => NavigationScreen(),
          //ChatScreen.id: (context) => ChatScreen(),
        }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentTab = 0;
  int pageNum = 0;

  void _selectTab(int tab) {
    setState(() {
      _currentTab = tab;
      pageNum = tab;
    });
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
            HomeScreen(),
            MessagingScreen(),
            NavigationScreen(),
            DetailsScreen(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toDetails,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void toDetails() { setState(() { pageNum = 3; }); }
}

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  DateTime selectedDate = DateTime.now();

  @override
  _DetailsScreen createState() => _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {

    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate,
        firstDate: new DateTime.now(),
        lastDate: new DateTime.now().add(new Duration(days: 30)),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.highContrastLight(
                primary: color[100],
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            child: child,
          );
        },
      );
      if (picked != null && picked != widget.selectedDate)
        setState(() {
         widget.selectedDate = picked;
        });
    }

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return color[100];
      }
      return color[200];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Job'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),

              child: Card(
                child: TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.location_pin),
                    hintText: 'Location of job',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Card(
                child: TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.streetview),
                    hintText: 'Address of this job',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Card(
                child: TextField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.map),
                  hintText: 'What time would you like a doer to show up?',
                ),
               ),
              ),
            ),
            //TODO:: implement a date time picker https://www.google.com/search?sxsrf=ALeKk00UXCBTKnN67smOX2XJEq-rpSDE_g%3A1615412445361&ei=3TxJYPm7FZeLtAaG4JjADA&q=date+time+picker+flutter+docs&oq=date+time+picker+flutter+docs&gs_lcp=Cgdnd3Mtd2l6EAMyBQgAEM0COgcIIxCwAxAnOgcIABCwAxBDOgcIABBHELADOgYIABAWEB46CAgAEBYQChAeOggIIRAWEB0QHjoFCCEQoAFQjkBY3EVg4kZoA3ACeACAAWeIAYEEkgEDNS4xmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwi5nuKn2KbvAhWXBc0KHQYwBsgQ4dUDCA4&uact=5#kpvalbx=_8TxJYIW3DvKP9PwPg_O0gAU29
            //TODO:: save this job posting onto the database
            //TODO:: Fine Tune UI to look consistent
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}