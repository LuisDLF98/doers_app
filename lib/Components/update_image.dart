import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';

void updateImage(String id, String imageUrl) {
  FirebaseFirestore.instance.collection('Users').doc(id).update({
    "profileImage": imageUrl,
  });
}
Widget getImage(String id) {
  return new StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').doc(id).snapshots(),
      builder: (context, snapshot) {
        var document = snapshot.data;
        String url = document['profileImage'];
        if (!snapshot.hasData ||  url.isEmpty) {
          return CircleAvatar(
            child: Icon(
              Icons.person,
              color: color[300],
            ),
            backgroundColor: color[100],
          );

        }
        return CircleAvatar(
          foregroundImage: NetworkImage(url),
        );
      }
  );
}
