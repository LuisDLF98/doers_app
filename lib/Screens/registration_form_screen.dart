import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:doers_app/constants.dart';
import 'package:doers_app/globals.dart';

class RegistrationFormScreen extends StatefulWidget {
  static const String id = 'registration_form_screen';

  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  String firstName;
  String lastName;
  String email;
  String streetAddress;
  String city;
  String state;
  String zipCode;
  String cellPhoneNumber;
  var cb;
  var fillC;
  var textC;
  var ic;
  var hintTextC;

  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    // For getting the User ID argument from 'registration_screen.dart'
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    // TODO: Add input checking through regex (particularly for email address)
    return Scaffold(
      backgroundColor: cb,
      appBar: AppBar(
        title: Text('Registration Details'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/DoersV3.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  style: TextStyle(color: textC),
                  onChanged: (value) {
                    //Do something with the user input.
                    firstName = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillC,
                    icon: Icon(Icons.perm_identity, color: ic),
                    hintText: 'First name',
                    hintStyle: TextStyle(color: hintTextC),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[50], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[100], width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "First name needed!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  style: TextStyle(color: textC),
                  onChanged: (value) {
                    //Do something with the user input.
                    lastName = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillC,
                    icon: Icon(Icons.perm_identity, color: ic),
                    hintText: 'Last name',
                    hintStyle: TextStyle(color: hintTextC),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[50], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[100], width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Last name needed!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  style: TextStyle(color: textC),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email= value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillC,
                    icon: Icon(Icons.email, color: ic),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: hintTextC),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: color[50], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: color[100], width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Email needed!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  style: TextStyle(color: textC),
                  onChanged: (value) {
                    //Do something with the user input.
                    streetAddress = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillC,
                    icon: Icon(Icons.house, color: ic),
                    hintText: 'Street address',
                    hintStyle: TextStyle(color: hintTextC),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[50], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[100], width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Street address needed!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  style: TextStyle(color: textC),
                  onChanged: (value) {
                    //Do something with the user input.
                    city = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillC,
                    icon: Icon(Icons.location_city, color:ic),
                    hintText: 'City',
                    hintStyle: TextStyle(color: hintTextC),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[50], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[100], width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "City needed!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  style: TextStyle(color: textC),
                  onChanged: (value) {
                    //Do something with the user input.
                    state = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillC,
                    icon: Icon(Icons.art_track, color: ic),
                    hintText: 'State',
                    hintStyle: TextStyle(color: hintTextC),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[50], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[100], width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "State needed!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  style: TextStyle(color: textC),
                  onChanged: (value) {
                    //Do something with the user input.
                    zipCode = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillC,
                    icon: Icon(Icons.location_on, color: ic),
                    hintText: 'Zip code',
                    hintStyle: TextStyle(color: hintTextC),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[50], width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color[100], width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Zip code needed!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 25),
                  child: RoundedButton(
                    colour: color[200],
                    title: 'Submit',
                    onPressed: () async {
                      if(formKey.currentState.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'You have been registered!')));
                        final firestoreInstance = FirebaseFirestore.instance;
                        DocumentReference docRef = await firestoreInstance
                            .collection('Users').add({
                          "email": email.toLowerCase(),
                          "firstName": firstName,
                          "lastName": lastName,
                          "streetAddress": streetAddress,
                          "city": city,
                          "state": state,
                          "zipCode": zipCode,
                          "profileImage": ""
                            });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              WelcomeScreen()),
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                              'Information still needed!')));
                      }
                    }, // onPressed
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
