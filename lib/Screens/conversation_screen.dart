import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart' as appColor;
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String contactName = "";

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
            return new Text('${document["firstName"]} ${document["lastName"]}', style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),);
          }
      );
    }

    Widget getInitial(String id) {
      return new StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').doc(id).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading", style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),);
            }
            var document = snapshot.data;
            contactName = '${document["firstName"]} ${document["lastName"]}';
            return new Text(contactName.substring(0, 1), style: TextStyle(color: appColor.fromHex('#000000')),);
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
                  CircleAvatar(
                    child: getInitial(info[1]),
                    backgroundColor: appColor.fromHex('#69efad'),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(contactName, style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
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
                          padding: EdgeInsets.only(left: 100, right: 0,top: 0,bottom: 0),
                          child: Card(
                              child: ListTile(
                                //leading: new Text('${date.month}/${date.day}\n${date.hour}:${date.minute}'),
                                title: new Text(info[3]),
                                subtitle: new Text(document['content']),
                                trailing: CircleAvatar(
                                  child: new Text(info[3].substring(0, 1), style: TextStyle(color: appColor.fromHex('#000000'))),
                                  backgroundColor: appColor.fromHex('#69efad'),
                                ),
                              )
                          ),
                        );
                      }
                      else {
                        return Padding(
                            padding: EdgeInsets.only(left: 0, right: 100,top: 0,bottom: 0),
                            child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: new Text(contactName.substring(0, 1), style: TextStyle(color: appColor.fromHex('#000000'))),
                                    backgroundColor: appColor.fromHex('#69efad'),
                                  ),
                                  title: new Text(contactName),
                                  subtitle: new Text(document['content']),
                                  //trailing: new Text('${date.month}/${date.day}\n${date.hour}:${date.minute}'),
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
                        color: appColor.fromHex('#69efad'),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
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
                          hintStyle: TextStyle(color: Colors.black54),
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
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: appColor.fromHex('#69efad'),
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