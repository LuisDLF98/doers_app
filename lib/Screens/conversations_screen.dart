import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:doers_app/Components/conversation_list.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Screens/conversation_screen.dart';

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

    String getConversationID(String userID, String peerID) {
      return userID.hashCode <= peerID.hashCode
          ? userID + '_' + peerID
          : peerID + '_' + userID;
    }

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

            return new ListView(
              children: snapshot.data.docs.map<Widget>((document) {
                List<dynamic> users = document['users'];
                if (users.contains('${loginInfo[0]}')) {
                  return Card(
                      child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: color[100],
                          ),
                          title: new Text('${loginInfo[0] != document['lastMessage']['idFrom'] ? document['lastMessage']['idFrom'] : document['lastMessage']['idTo']}'),
                          subtitle: new Text(document['lastMessage']['content']),
                          // trailing: new Text(document['date']),
                          onTap: () {
                            Navigator.pushNamed(context, ConversationDetailPage.id, arguments: {'convoID': document.id});
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