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
    final formKey = GlobalKey<FormState>();

    // TODO: Add input checking through regex (particularly for email address)
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
                  onChanged: (value) {
                    //Do something with the user input.
                    firstName = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    hintText: 'First name',
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
                  onChanged: (value) {
                    //Do something with the user input.
                    lastName = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    hintText: 'Last name',
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
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email= value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Email',
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
                  onChanged: (value) {
                    //Do something with the user input.
                    streetAddress = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.house),
                    hintText: 'Street address',
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
                  onChanged: (value) {
                    //Do something with the user input.
                    city = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city),
                    hintText: 'City',
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
                  onChanged: (value) {
                    //Do something with the user input.
                    state = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.art_track),
                    hintText: 'State',
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
                  onChanged: (value) {
                    //Do something with the user input.
                    zipCode = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_on),
                    hintText: 'Zip code',
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
                          "zipCode": zipCode});
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
