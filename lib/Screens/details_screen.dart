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
  TimeOfDay selectedTime = TimeOfDay.now();

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

    _selectTime(BuildContext context) async {
      final TimeOfDay newtime = await showTimePicker(
          context: context,
          initialTime: widget.selectedTime,
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

      if (newtime != null) {
        setState(() {
          widget.selectedTime = newtime;
        });
      }
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
                    icon: Icon(Icons.attach_money),
                    hintText: 'Payment Offered',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Card(
                child: TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.tag),
                    hintText: 'Job type',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Card(
                child: TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: 'Description',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () => _selectDate(context),
                child: Text("Select Date (MM-DD-YYYY): ${widget.selectedDate.month.toString()}-${widget.selectedDate.day.toString()}-${widget.selectedDate.year.toString()}"),
                style: TextButton.styleFrom(
                  primary: color[300],
                  backgroundColor: color[200],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextButton(
                onPressed: () => _selectTime(context),
                child: Text("Select Time: ${widget.selectedTime.format(context)}"),
                style: TextButton.styleFrom(
                  primary: color[300],
                  backgroundColor: color[200],
                ),
              ),
            ),
            //TODO:: save this job posting onto the database
            //TODO:: Fine Tune UI to look consistent
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}