import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:doers_app/Components/conversation_list.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Screens/conversation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:doers_app/Components/update_image.dart';

class MessagingScreen extends StatefulWidget {
  MessagingScreen({Key key, this.userData}) : super(key: key);
  static const String id = 'conversations_screen';
  final List<String> userData;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MessagingScreen createState() => _MessagingScreen(userData);
}

class _MessagingScreen extends State<MessagingScreen> {

  List<String> loginInfo;
  _MessagingScreen(this.loginInfo);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      drawer: NavDrawer(userData: loginInfo),
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Conversations').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            Widget getName(String id) {
              return new StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Users').doc(id).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new Text("Loading");
                    }
                    var document = snapshot.data;
                    return new Text('${document["firstName"]} ${document["lastName"]}');
                  }
              );
            }

            return new ListView(
              children: snapshot.data.docs.map<Widget>((document) {
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<dynamic> users = document['users'];
                Map<String, dynamic> lastMessage = document['lastMessage'];
                String contact;
                loginInfo[0] != document['lastMessage']['idFrom'] ?
                contact = document['lastMessage']['idFrom'] :
                contact = document['lastMessage']['idTo'];
                DateTime date = DateTime.fromMicrosecondsSinceEpoch(document['lastMessage']['timestamp']);

                if (users.contains('${loginInfo[0]}')) {
                  return Card(
                      child: ListTile(
                          leading: getImage(contact),
                          title: getName(contact),
                          subtitle: new Text(document['lastMessage']['content']),
                          trailing: new Text('${date.month}/${date.day}\n${date.hour}:${date.minute}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ConversationDetailPage(
                                          data: {
                                            loginInfo[0], // user's id
                                            contact, // contact's id
                                            document.id, // document id
                                            loginInfo[1], // user's name
                                          }.toList()
                                      )
                              ),
                            );
                          }
                      )
                  );
                }
                else {
                  return SizedBox.shrink();
                }
              }).toList(),
            );
          }
      ),
    );
  }
}