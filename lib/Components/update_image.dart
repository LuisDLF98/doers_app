import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_app/Components/hex_colors.dart';
import 'dart:async';

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
        String url;
        if (snapshot.hasData) {
          url = document['profileImage'];
          if (url.isNotEmpty) {
            return CircleAvatar(
              foregroundImage: NetworkImage(url),
              maxRadius: 20,
            );
          }
        }

        return CircleAvatar(
          child: Icon(
            Icons.person,
            color: color[300],
          ),
          backgroundColor: color[100],
          maxRadius: 20,
        );

      }
  );
}
