import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

final formKey = GlobalKey<FormState>();

Map<String, Icon> jobCategoryIcon = {
  'Yard Services': Icon(Icons.grass, color: color[100]),
  'Plumbing': Icon(Icons.plumbing, color: color[100]),
  'Electrical': Icon(Icons.electrical_services, color: color[100]),
  'Construction': Icon(Icons.construction, color: color[100]),
  'Cleaning Services': Icon(Icons.cleaning_services, color: color[100]),
  'Pet Services': Icon(Icons.pets, color: color[100]),
  'Food Services': Icon(Icons.restaurant, color:color[100]),
  'Other': Icon(Icons.build, color: color[100])
};