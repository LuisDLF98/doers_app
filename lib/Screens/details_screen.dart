import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static const String id = 'details_screen';
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
  String email;
  String timeRange;
  var txt = TextEditingController();
  var txt1 = TextEditingController();
  Duration jobDuration = Duration(hours: 0, minutes: 0);

  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  bool isVis=true;

  @override


  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyCac6e3vO4ib9gR5tMEsJcyiOiiMi1-tD0";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var url = Uri.parse(request);
    var response = await http.get(url);
    print(response);

    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }


  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    id = arguments[0];

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
      backgroundColor: color[500],
      appBar: AppBar(
        title: Text('Create Job'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _controller,
                    onChanged: (value) {
                      isVis=true;
                      //Do something with the user input.
                      //streetAddress = value;
                      //print(streetAddress);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: color[300],
                      //focusColor: color[100],
                      icon: Icon(Icons.location_pin),
                      hintText: 'Address of this job',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[50], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[100], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),

                  ),
                  Visibility(
                    visible: isVis,
                    child:
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,

                      itemCount: _placeList.length,
                      //controller: _controller,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_placeList[index]["description"]),
                          onTap: () {
                            //print(_placeList[index]["description"]);
                            setState(() {
                              _controller.text=_placeList[index]["description"];
                              streetAddress = _placeList[index]["description"];
                              print(streetAddress);
                              isVis=false;
                            });

                          },
                        );
                      },
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      //Do something with the user input.
                      payment = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: color[300],
                      //focusColor: color[100],
                      icon: Icon(Icons.attach_money),
                      hintText: 'Payment offered',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[50], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[100], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      //Do something with the user input.
                      jobType = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: color[300],
                      //focusColor: color[100],
                      icon: Icon(Icons.tag),
                      hintText: 'Job type',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[50], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[100], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      //Do something with the user input.
                      description = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: color[300],
                      //focusColor: color[100],
                      icon: Icon(Icons.description),
                      hintText: 'Description',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[50], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[100], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: txt,
                    showCursor: true,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                      txt.text = "${widget.selectedDate.month.toString()}-${widget.selectedDate.day.toString()}-${widget.selectedDate.year.toString()}";

                    },
                    onChanged: (value) {
                      //Do something with the user input.
                       // = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: color[300],
                      //focusColor: color[100],
                      icon: Icon(Icons.calendar_today_rounded),
                      hintText: 'Select date',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[50], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[100], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: txt1,
                    showCursor: true,
                    readOnly: true,
                    onTap: () async {

                        TimeRange result = await showTimeRangePicker(
                        context: context,
                        fromText: "",
                        toText: "",
                        use24HourFormat: false,
                        labelOffset: -30,
                        strokeWidth: 6,
                        ticks: 8,
                        ticksColor: color[500],
                        ticksLength: 20,
                        ticksOffset: -3,
                        timeTextStyle: TextStyle(
                          fontSize: 20,
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
                      //_selectTime(context);
                      //widget.selectedTime.toString()

                        String start = result.startTime.toString();
                        String end = result.endTime.toString();

                        
                      txt1.text= start.substring(10,15) + '-' + end.substring(10,15);

                    },
                    onChanged: (value) {
                      //Do something with the user input.
                       timeRange = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: color[300],
                      //focusColor: color[100],
                      icon: Icon(Icons.watch_later),
                      hintText: 'Select start/end time',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[50], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: color[100], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  // TODO: Verify whether or not the TimeRangePicker will be sufficient
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 25),
                child: RoundedButton(
                  colour: color[200],
                  title: 'Submit',
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Job created!')
                      )
                    );
                    final firestoreInstance = FirebaseFirestore.instance;
                    firestoreInstance.collection("Task Listings").add({
                      "address": streetAddress,
                      "payment": payment,
                      "jobType": jobType,
                      "description": description,
                      "date": widget.selectedDate,
                      // "duration": jobDuration,
                      "timeRange" : timeRange,
                      // TODO: entry time to database
                      "ownedBy": id,
                      "isCompleted": false,
                      "doerAssigned": null,
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
