import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/user.dart';

class NewConversationScreen extends StatelessWidget {
  const NewConversationScreen(
      {@required this.uid, @required this.contact, @required this.convoID});
  final String uid, convoID;
  final OurUser contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(automaticallyImplyLeading: true, title: Text(contact.name))
      //body: ChatScreen(uid: uid, convoID: convoID, contact: contact));
    );
  }
}

class UserRow extends StatelessWidget {
  const UserRow( this.uid, this.contact);
  final String uid;
  final OurUser contact;

  String getConversationID(String userID, String contactID) {
    return userID.hashCode <= contactID.hashCode
        ? userID + '_' + contactID
        : contactID + '_' + userID;
  }

  void createConversation(BuildContext context) {
    String conversationID = getConversationID(uid, contact.uid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => NewConversationScreen(uid: uid, contact: contact, convoID: conversationID)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => createConversation(context),
      child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          child: Center(
              child: Text(contact.name,
                  style:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)))),
    );
  }
}