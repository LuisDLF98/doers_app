import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:doers_app/Components/conversation_list.dart';
import 'package:doers_app/models/chat_users.dart';
import 'package:doers_app/Components/hex_colors.dart' as appColor;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:doers_app/Screens/conversation_screen.dart';
import 'package:doers_app/Components/user_row.dart';
import 'package:doers_app/Components/user.dart';


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
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "images/DoersV3.png", time: "Now"),
    ChatUsers(name: "Glady's Murphy", messageText: "That's Great", imageURL: "images/Rusty.jpeg", time: "Yesterday"),
    ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "images/Rusty.jpeg", time: "31 Mar"),
    ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "images/Rusty.jpeg", time: "28 Mar"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "images/Rusty.jpeg", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "images/Rusty.jpeg", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "images/Rusty.jpeg", time: "24 Feb"),
    ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "images/Rusty.jpeg", time: "18 Feb"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "images/Rusty.jpeg", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "images/Rusty.jpeg", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "images/Rusty.jpeg", time: "24 Feb"),
    ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "images/Rusty.jpeg", time: "18 Feb"),
  ];

  List<String> loginInfo;
  _MessagingScreen(this.loginInfo);

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    final List<OurUser> userDirectory = <OurUser>[];
    final fireInstance = FirebaseFirestore.instance;
    CollectionReference conversations = fireInstance.collection('Conversations');

    List<Widget> getListViewItems(List<OurUser> userDirectory, User user) {
      final List<Widget> list = <Widget>[];
      for (OurUser contact in userDirectory) {
        if (contact.uid != user.uid) {
          list.add(UserRow(user.uid, contact));
        }
      }
      return list;
    }

    return Scaffold(

      backgroundColor: Colors.white,
      drawer: NavDrawer(userData: loginInfo),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Conversations'),
      ),
      body: userDirectory != null
        ? ListView(
        shrinkWrap: true, children: getListViewItems(userDirectory, user)
      ) : Container(),
    );
  }
}