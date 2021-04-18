import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:settings_ui/settings_ui.dart';

import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);
  static const String id = 'settings_screen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  bool val = false;
  String streetAddress;
  String city;
  String state;
  String zipCode;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showEditAddressDialog(BuildContext context, Map args) async {

    return await showDialog(context: context,
        builder: (context){

          final TextEditingController _zipcodeController = TextEditingController();
          final TextEditingController _stateController = TextEditingController();
          final TextEditingController _cityController = TextEditingController();
          final TextEditingController _streetController = TextEditingController();
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Enter your new address"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 15.0)),
                  TextFormField(
                    controller: _streetController,
                    validator: (value){
                      return value.isNotEmpty ? null : "Street address needed!";
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
                    onChanged: (value){
                      streetAddress = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _cityController,
                    validator: (value){
                      return value.isNotEmpty ? null: "City needed!";
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
                    onChanged: (value){
                      city = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _stateController,
                    validator: (value){
                      return value.isNotEmpty ? null: "State needed!";
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
                    onChanged: (value){
                      state = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _zipcodeController,
                    validator: (value){
                      return value.isNotEmpty ? null: "Zip code needed!";
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
                    onChanged: (value){
                      zipCode = value;
                    },
                  ),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                        final firestoreInstance = FirebaseFirestore.instance;
                        DocumentReference userRef = firestoreInstance.collection('Users').doc(args['userInfo'][0]);

                            userRef.update(
                            {"streetAddress": streetAddress,
                            "city": city,
                            "state": state,
                            "zipCode": zipCode,});
                        Navigator.of(context).pop();
                    }
                  },
                  child: Text('Submit'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Settings'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SettingsList(

          backgroundColor: fromHex('#cfd8dc'),
          sections: [
            SettingsSection(
              title: 'General',
              titleTextStyle: TextStyle(color: fromHex('#2bbc7d'), fontWeight: FontWeight.bold, fontSize: 18
              ),
              tiles: [
                  SettingsTile(
                    title: 'Address',
                    leading: Icon(Icons.house),
                    onPressed: (BuildContext context) async {
                      await showEditAddressDialog(context, arguments);
                    },),
                  SettingsTile.switchTile(title: 'Dark Mode',
                      leading: Icon(Icons.lightbulb_outline),
                      onToggle: (bool val){},
                      switchValue: val),
              ],

            ),
            SettingsSection(
              title: 'Misc',
              titleTextStyle: TextStyle(color: fromHex('#2bbc7d'), fontWeight: FontWeight.bold, fontSize: 18),
              tiles: [
                SettingsTile(
                    title: 'Terms of Service', leading: Icon(Icons.description)),
                SettingsTile(
                    title: 'Open source licenses',
                    leading: Icon(Icons.collections_bookmark)),
              ],
            ),
          ],
        ),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
