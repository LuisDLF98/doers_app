import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/userinfo.email',
  ],
);


final FirebaseAuth _auth = FirebaseAuth.instance;

String name;
String email;
String imageUrl;
String id;

Future<bool> checkIfRegistered(String email) async {
  bool b = false;
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference ref = firestoreInstance.collection('Users');
  QuerySnapshot qShot = await ref.get();
  qShot.docs.forEach((doc) {
    String s = doc.data()['email'];
    if(email == s) {
      id = doc.reference.id;
      b = true;
    }
  });

  return Future.value(b);
}

Future<List<String>> signInWithGoogle() async {
  await Firebase.initializeApp();

  List<String> result = [];

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount == null) {
    print('User didn\'t sign in');
    return null;
  }
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
  await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    // Only taking the first part of the name, i.e., First Name
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    bool isRegistered = await checkIfRegistered(email);
    if (!isRegistered) {
      signOutGoogle();
      result.add("Not Registered!");
      return result;
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');
    print('id: $id');

    result.add(id);
    result.add(name);
    result.add(email);
    result.add(imageUrl);
    result.add('$user');

    FirebaseFirestore.instance.collection('Users').doc(id).update({
      "profileImage": imageUrl,
    });

    return result;
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}