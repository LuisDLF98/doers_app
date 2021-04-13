import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static const String id = 'contacts_screen';
  final String title;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  _ContactsScreen createState() => _ContactsScreen();
}

class _ContactsScreen extends State<ContactsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color[500],
      appBar: AppBar(
        title: Text('Create Job'),
      ),
    );
  }
}
