import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/update_image.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class ConversationDetailPage extends StatefulWidget{
  ConversationDetailPage({Key key, this.data}) : super(key: key);
  static const String id = 'conversation_screen';
  final List<String> data;

  @override
  _ConversationDetailPageState createState() => _ConversationDetailPageState(this.data);
}

class _ConversationDetailPageState extends State<ConversationDetailPage> {
  List<String> info;
  _ConversationDetailPageState(this.info);
  String message;

  @override
  Widget build(BuildContext context) {
    Widget getName(String id) {
      return new StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').doc(id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading", style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),);
            }
            var document = snapshot.data;
            return new Text('${document["firstName"]} ${document["lastName"]}', style: TextStyle(fontSize: 16),);
          }
      );
    }

    void addMessage(String message) {
      if (message != null) {
        FirebaseFirestore.instance.collection('Conversations').doc(info[2]).collection('Messages').add({
          "content": message,
          "idFrom": info[0],
          "idTo": info[1],
          "read": false,
          "timestamp": DateTime.now().microsecondsSinceEpoch,
        });
        FirebaseFirestore.instance.collection('Conversations').doc(info[2]).update({
          'lastMessage': {
            "content": message,
            "idFrom": info[0],
            "idTo": info[1],
            "read": false,
            "timestamp": DateTime.now().microsecondsSinceEpoch,
          }
        });
      }
    }

    var _controller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  getImage(info[1]),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        getName(info[1]),
                        SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: color[500]),),
                      ],
                    ),
                  ),
                  Icon(Icons.settings,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 0, right: 0,top: 0,bottom: 65),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Conversations').doc(info[2]).collection('Messages').orderBy('timestamp', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return new ListView(
                    reverse: true,
                    children: snapshot.data.docs.map<Widget>((document) {
                      DateTime date = DateTime.fromMicrosecondsSinceEpoch(document['timestamp']);

                      if (info[0] == document['idFrom']) {
                        return Padding(
                          padding: EdgeInsets.only(left: 90, right: 0,top: 0,bottom: 0),
                          child: Card(
                              child: ListTile(
                                leading: new Text('${DateFormat.MMMd().format(date)}\n${DateFormat.jm().format(date)}'),
                                title: new Text(info[3]),
                                subtitle: new Text(document['content']),
                                trailing: getImage(info[0])
                              )
                          ),
                        );
                      }
                      else {
                        return Padding(
                            padding: EdgeInsets.only(left: 0, right: 90,top: 0,bottom: 0),
                            child: Card(
                                child: ListTile(
                                  leading: getImage(info[1]),
                                  title: getName(info[1]),
                                  subtitle: new Text(document['content']),
                                  trailing: new Text('${DateFormat.MMMd().format(date)}\n${DateFormat.jm().format(date)}'),
                                )
                            )
                        );
                      }
                    }).toList(),
                  );
                }
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: color[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: color[300], size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: color[600]),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () {
                      _controller.clear();
                      _controller.clearComposing();
                      addMessage(message);
                    },
                    child: Icon(Icons.send,color: color[300],size: 18,),
                    backgroundColor: color[100],
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),

    );
  }
}