import 'package:flutter/material.dart';
import 'package:doers_app/Components/side_bar.dart';
import 'package:doers_app/Components/conversation_list.dart';
import 'package:doers_app/models/chat_users.dart';
import 'package:doers_app/Components/hex_colors.dart' as appColor;

class MessagingScreen extends StatefulWidget {
  MessagingScreen({Key key}) : super(key: key);
  static const String id = 'message_screen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MessagingScreen createState() => _MessagingScreen();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Messaging'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold, color: Colors.black),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: appColor.fromHex('#69efad'),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add,color: Colors.black,size: 20,),
                          SizedBox(width: 2,),
                          Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}