import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';

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