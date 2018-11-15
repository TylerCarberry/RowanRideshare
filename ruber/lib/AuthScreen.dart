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

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      home: MyHomePage(title: 'Firebase Auth Demo'),
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
  TextEditingController _smsCodeController = TextEditingController();
  String verificationId;
  final String testSmsCode = '888888';
  final String testPhoneNumber = '+1 408-555-6969';

  Future<String> _testSignInAnonymously() async {
    final FirebaseUser user = await _auth.signInAnonymously();
    assert(user != null);
    assert(user.isAnonymous);
    assert(!user.isEmailVerified);
    assert(await user.getIdToken() != null);
    if (Platform.isIOS) {
      // Anonymous auth doesn't show up as a provider on iOS
      assert(user.providerData.isEmpty);
    } else if (Platform.isAndroid) {
      // Anonymous auth does show up as a provider on Android
      assert(user.providerData.length == 1);
      assert(user.providerData[0].providerId == 'firebase');
      assert(user.providerData[0].uid != null);
      assert(user.providerData[0].displayName == null);
      assert(user.providerData[0].photoUrl == null);
      assert(user.providerData[0].email == null);
    }

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInAnonymously succeeded: $user';
  }

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
    if(user.getIdToken() == null){
      var now = new DateTime.now();
      NewUser newUser = new NewUser(user.displayName,user.email,now,"-1",user.uid);
//      NewUser newUser = new NewUser(user.uid, user.displayName,user.email,now,user.uid,"-1",user.uid);
      createPost(newUser).then((response){
        if(response.statusCode > 200)
          print(response.body);
        else
          print(response.statusCode);
      }).catchError((error){
        print('error : $error');
      });
    }

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  Future<void> _testVerifyPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser user) {
      setState(() {
        _message =
            Future<String>.value('signInWithPhoneNumber auto succeeded: $user');
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message = Future<String>.value(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      _smsCodeController.text = testSmsCode;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      _smsCodeController.text = testSmsCode;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: testPhoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<String> _testSignInWithPhoneNumber(String smsCode) async {
    final FirebaseUser user = await _auth.signInWithPhoneNumber(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    _smsCodeController.text = '';
    return 'signInWithPhoneNumber succeeded: $user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          MaterialButton(
              child: const Text('Sign In With Google'),
              onPressed: () {
                setState(() {
                  _message = _testSignInWithGoogle();
                });
              }),


          FutureBuilder<String>(
              future: _message,
              builder: (_, AsyncSnapshot<String> snapshot) {
                return Text(snapshot.data ?? '',
                    style:
                        const TextStyle(color: Color.fromARGB(255, 0, 155, 0)));
              }),
        ],
      ),
    );
  }
}

class NewUser{
//  String id;
  String name;
  String email;
  var createdDate;
  var schedules;
  var address;
  String chatroom;
//  var schedules;
  NewUser(String name, String email, var createdDate, var schedules, String chatroom){
//  NewUser(String id,String name, String email, var createdDate, var schedules, var address, String chatroom){
//    this.id = id;
    this.name =name;
    this.email =email;
    this.createdDate = createdDate;
    this.schedules = schedules;
//    this.address = address;
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