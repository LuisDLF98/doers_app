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

  @override
  Widget build(BuildContext context) {
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
                    onPressed: (BuildContext context) {},),
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
