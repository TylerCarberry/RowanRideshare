// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';
import 'dart:async' show Future;
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:ruber/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserModel.dart';
import 'initialaddaddress.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();


class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign into Rowan',
      home: MyHomePage(title: 'Sign into Rowan',),
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

  String emailAddress = "";


  getEmailAddress() {
    return emailAddress;
  }

  setEmailAddress(String newEmail) async {
    emailAddress = newEmail;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", newEmail);
  }


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

    /*
    *This is where new users are created for first time logins
    * this logic should work but might need to happen else where
    * address schedule and chatroom are all null for now
     */

    //This if statement need to check for first time login

    String tempName = user.displayName.toString();

    String tempEmail = user.email.toString();

    NewUser tempUser = NewUser(name: tempName, email: tempEmail);
    setEmailAddress(tempEmail);
    createUser(tempUser).then((response) {
      if (response.statusCode > 200) {
        print(tempEmail);
        print(response.body);
      }
      else
        print(response.statusCode);
    }).catchError((error) {
      print('error : $error');
    });


    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            InitialAddressForm(
                emailAddress))); // Should be changed to AuthScreen.dart which should go to InitialAddressForm.dart


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
            onPressed: () {
              setState(() {
                _message = _testSignInWithGoogle();
                emailAddress = getEmailAddress();
              });
            },

          ),


        ],
      ),

    );
  }

  Future<http.Response> createUser(NewUser user) async {
    String updateUrl = BASE_URL + '/rides/profile/new';
    final response = await http.post('$updateUrl',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: ''
        },
        body: userToJson(user)
    );
    return response;
  }


/*
  Future<http.Response> createAddress(AddressPost address) async {
    String userId = getId();
    print(userId);
    String updateUrl = BASE_URL + '/rides/address/$userId/new';
    final response = await http.post('$updateUrl',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: ''
        },
        body: addressPostToJson(address));
    return response;
  }

*/

}

