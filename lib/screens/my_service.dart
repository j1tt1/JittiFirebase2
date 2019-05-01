import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// For Firebase
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    String currentUid = firebaseUser.uid.toString();

    var objData = firebaseDatabase.reference().child(currentUid);
    print('objData ==> $objData');
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        print('You Click Sign Out');
        signOutProcess();
      },
    );
  }

  void signOutProcess() async {
    // SignOut From Firbase
    await firebaseAuth.signOut();
    // Exit App
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JN Service'),
        actions: <Widget>[signOutButton()],
      ),
      body: Text('This is My Service'),
    );
  }
}
