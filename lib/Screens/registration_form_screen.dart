import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Components/rounded_button.dart';

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

  @override
  Widget build(BuildContext context) {
    // For getting the User ID argument from 'registration_screen.dart'
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      backgroundColor: color[500],
      appBar: AppBar(
        title: Text('Registration Details'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
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
                  onChanged: (value) {
                    //Do something with the user input.
                    firstName = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    hintText: 'Enter your First Name',
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
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    //Do something with the user input.
                    lastName = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    hintText: 'Enter your Last Name',
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
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email= value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Enter your email',
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
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    //Do something with the user input.
                    streetAddress = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.house),
                    hintText: 'street address',
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
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    //Do something with the user input.
                    city = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city),
                    hintText: 'city',
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
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    //Do something with the user input.
                    state = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.art_track),
                    hintText: 'state',
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
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    //Do something with the user input.
                    zipCode = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_on),
                    hintText: 'zip code',
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
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('You have been registered!')));
                      final firestoreInstance = FirebaseFirestore.instance;
                      DocumentReference docRef = await firestoreInstance.collection('Users').add({
                        "email": email,
                        "firstName": firstName,
                        "lastName": lastName,
                        "streetAddress": streetAddress,
                        "city": city,
                        "state": state,
                        "zipCode": zipCode,
                        "profileImage": null,
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      );
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
