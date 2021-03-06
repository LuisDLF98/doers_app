import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doers_app/globals.dart';


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
  String id;
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

  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  bool isVis=true;

  @override

  var cb;
  var fillC;
  var textC;
  var ic;
  var hintTextC;

  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
    if(nightMode){
      cb = color[600];
      fillC = color[650];
      textC = color[300];
      ic = color[300];
      hintTextC = color[400];
    }
    else{
      cb = color[400];
      fillC = color[300];
      textC = color[600];
      ic = color[200];
      hintTextC= color[500];

    }
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
    id = arguments['userInfo'][0];

    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate,
        firstDate: new DateTime.now(),
        lastDate: new DateTime.now().add(new Duration(days: 30)),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.highContrastDark(
                primary: color[200],
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

    return Scaffold(
      backgroundColor: cb,
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
                    style: TextStyle(color: textC),
                    controller: _controller,
                    onChanged: (value) {
                      isVis=true;
                      //Do something with the user input.
                      //streetAddress = value;
                      //print(streetAddress);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fillC,
                      //focusColor: color[100],
                      icon: Icon(Icons.location_pin,
                      color: ic,),
                      hintText: 'Address of this job',
                      hintStyle: TextStyle(color: hintTextC),
                      //labelStyle: TextStyle(color: textC),
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
                          title: Text(_placeList[index]["description"], style: TextStyle(color: textC),),

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
                      fillColor: fillC,
                      //focusColor: color[100],
                      icon: Icon(Icons.attach_money, color: ic),
                      hintText: 'Payment offered',
                      hintStyle: TextStyle(color: hintTextC),
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
                  DropdownButtonFormField(
                    icon: Icon(Icons.arrow_drop_down, color: color[100]),
                    items:["Yard Services","Plumbing","Electrical", 'Pet Services','Construction','Cleaning Services', 'Food Services', 'Other']
                      .map((label)=> DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                    .toList(),
                    onChanged: (value){
                    setState(() => jobType = value);
                       },

                    decoration: InputDecoration(

                      filled: true,
                      fillColor: fillC,
                      //focusColor: color[100],
                      icon: Icon(Icons.tag, color:ic),
                      hintText: 'Job type',
                      hintStyle: TextStyle(color: hintTextC),
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
                      fillColor: fillC,
                      //focusColor: color[100],
                      icon: Icon(Icons.description, color: ic),
                      hintText: 'Description',
                      hintStyle: TextStyle(color: hintTextC),
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
                      fillColor: fillC,
                      //focusColor: color[100],
                      icon: Icon(Icons.calendar_today_rounded, color: ic),
                      hintText: 'Select date',
                      hintStyle: TextStyle(color: hintTextC),
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
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData(
                              colorScheme: ColorScheme.highContrastDark(
                                primary: color[100],
                              ),
                              visualDensity: VisualDensity
                                  .adaptivePlatformDensity,
                            ),
                            child: child,
                          );
                        },
                        handlerColor: color[100],
                        strokeColor: color[200],
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
                          color: color[100],
                        ),
                        labels: [
                          "12 am",
                          "3 am",
                          "6 am",
                          "9 am",
                          "12 pm",
                          "3 pm",
                          "6 pm",
                          "9 pm",
                        ]
                            .asMap()
                            .entries
                            .map((e) {
                          return ClockLabel.fromIndex(
                              idx: e.key, length: 8, text: e.value
                          );
                        }).toList(),
                      );
                      //_selectTime(context);
                      //widget.selectedTime.toString()
                      String start = result.startTime.toString();
                      String end = result.endTime.toString();

                      timeRange = start.substring(10, 15) + '-' + end.substring(10, 15);
                      txt1.text = start.substring(10, 15) + '-' + end.substring(10, 15);
                    },
                    onChanged: (value) {
                      //Do something with the user input.
                       timeRange = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fillC,
                      //focusColor: color[100],
                      icon: Icon(Icons.watch_later, color: ic),
                      hintText: 'Select start/end time',
                      hintStyle: TextStyle(color: hintTextC),
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
                    DateTime end = widget.selectedDate;
                    firestoreInstance.collection("Task Listings").add({
                      "address": streetAddress,
                      "payment": payment,
                      "jobType": jobType,
                      "description": description,
                      "date": widget.selectedDate.add(Duration(
                        hours: int.parse(timeRange.substring(0, 2)),
                        minutes: int.parse(timeRange.substring(3, 5))
                      )),
                      "timeRange" : end.add(Duration(
                        hours: int.parse(timeRange.substring(6, 8)),
                        minutes: int.parse(timeRange.substring(9, 11))
                      )),
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
