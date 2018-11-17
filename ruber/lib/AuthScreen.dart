// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'initialaddaddress.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign into Rowan',
      home: MyHomePage(title: 'Sign into Rowan', ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<String> _message = Future<String>.value('');

  String verificationId;


  Future<String> _testSignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    var now = new DateTime.now();
    if(user.getIdToken() == null){
      NewUser newUser = new NewUser(user.uid, user.displayName,user.email,now,null,null, null);
      createPost(newUser);
    }

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              child: const Text('Sign in to Rowan'),
              onPressed: ()
              {
                setState(() {
                  _message = _testSignInWithGoogle();

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (
                          context) => InitialAddressForm())); // Should be changed to AuthScreen.dart which should go to InitialAddressForm.dart
                });
              },

              ),
        ],
      ),

    );
  }
}

class NewUser{
  String id;
  String name;
  String email;
  var createdDate;
  var schedules;
  var address;
  var chatroom;
//  var schedules;
  NewUser(String id,String name, String email, var createdDate, var schedules, var address, var chatroom){
    this.id = id;
    this.name =name;
    this.email =email;
    this.createdDate = createdDate;
    this.schedules = schedules;
    this.address = address;
    this.chatroom = chatroom;
  }

//  factory NewUser.fromJson(Map<String, dynamic> parsedJson) {
//    return NewUser(
//      id: parsedJson["id"],
//      name: parsedJson["name"],
//      email: parsedJson["email"],
//      createdDate: parsedJson["createdDate"],
//
//    );}

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "email": email,
        "createdDate": createdDate,
        "schedules":schedules,
        "address":address,
        "chatroom":chatroom,
      };


}

String postToJson(NewUser data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
String url = 'http://10.0.2.2:8080/rides/profile/new';
Future<http.Response> createPost(NewUser post) async {
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: postToJson(post));
  return response;
}