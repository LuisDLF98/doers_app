import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String id; // TODO: Link this to a unique user
  String streetAddress;
  String city; // Pull these three from the database via streetAddress
  String state;
  String zipCode;
  String payment;
  String jobType;
  String description;
  Duration jobDuration = Duration(hours: 0, minutes: 0);


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
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(7.5),
                  child: Card(
                    child: TextField(
                      onChanged: (value) {
                        streetAddress = value;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_pin),
                        hintText: 'Address of this job',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.5),
                  child: Card(
                    child: TextField(
                      onChanged: (value) {
                        payment = value;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.attach_money),
                        hintText: 'Payment Offered',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.5),
                  child: Card(
                    child: TextField(
                      onChanged: (value) {
                        jobType = value;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.tag),
                        hintText: 'Job type',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.5),
                  child: Card(
                    child: TextField(
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.description),
                        hintText: 'Description',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7.5),
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                        "Select Date (MM-DD-YYYY): ${widget.selectedDate.month.toString()}-${widget.selectedDate.day.toString()}-${widget.selectedDate.year.toString()}"),
                    style: TextButton.styleFrom(
                      primary: color[300],
                      backgroundColor: color[200],
                    ),
                  ),
                ),
                // TODO: Verify whether or not the TimeRangePicker will be sufficient
                /*Padding(
                  padding: EdgeInsets.all(7.5),
                  child: TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(
                        "Select Time: ${widget.selectedTime.format(context)}"),
                    style: TextButton.styleFrom(
                      primary: color[300],
                      backgroundColor: color[200],
                    ),
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.all(7.5),
                  child: TextButton(
                    onPressed: () async {
                      jobDuration = await showTimeRangePicker(
                          context: context,
                          use24HourFormat: false,
                          labelOffset: -30,
                          strokeWidth: 6,
                          ticks: 8,
                          ticksColor: color[500],
                          ticksLength: 20,
                          ticksOffset: -3,
                          timeTextStyle: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            //fontWeight: FontWeight.bold,
                          ),
                          activeTimeTextStyle: TextStyle(
                            fontSize: 26,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          labels: [
                            "12 pm",
                            "3 pm",
                            "6 pm",
                            "9 pm",
                            "12 am",
                            "3 am",
                            "6 am",
                            "9 am",
                          ].asMap().entries.map((e) {
                            return ClockLabel.fromIndex(
                              idx: e.key, length: 8, text: e.value
                            );
                          }).toList(),
                      );
                    },
                    child: Text(
                        "Select Start/End Time"),
                    style: TextButton.styleFrom(
                      primary: color[300],
                      backgroundColor: color[200],
                    ),
                  ),
                ),
                //TODO:: Fine Tune UI to look consistent
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 15.0, horizontal: 25),
              child: RoundedButton(
                colour: color[200],
                title: 'Submit',
                onPressed: () {
                  final firestoreInstance = FirebaseFirestore.instance;
                  firestoreInstance.collection("Task Listings").add({
                    "address": streetAddress,
                    "payment": payment,
                    "jobType": jobType,
                    "description": description,
                    "date": widget.selectedDate,
                    // "duration": jobDuration,
                  });
                },
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
