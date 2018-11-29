// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';
import 'dart:async' show Future;
import 'dart:io';
import 'dart:convert';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'UserModel.dart';
import 'initialaddaddress.dart';
import 'Main.dart';
import 'ProfileModel.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

String userName;
String userProfilePic;
List profileList;
int id;

getUserProfilePic(){
  return userProfilePic;
}

getUserName() {
  return userName;
}



setProfilePicture(String newPhotoUrl) async {
  userProfilePic = newPhotoUrl;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("photo", userProfilePic);
}

setUserName(String tempUserName) async {
  if(tempUserName.contains(" "))
    tempUserName = tempUserName.substring(0, tempUserName.indexOf(" "));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("username", tempUserName);
  userName = tempUserName;
}



/*
getId() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int tempId = prefs.getInt("id");
  if (tempId != 0 && tempId != null) {
    id = tempId;
  }

  return id;
}*/


String emailAddress = "";


getEmailAddress() {
  return emailAddress;
}

setEmailAddress(String newEmail) async {
  emailAddress = newEmail;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("email", newEmail);
}


class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAuthScreen(title: 'Sign into Rowan',),
    );
  }
}

class MyAuthScreen extends StatefulWidget {
  MyAuthScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAuthScreenState createState() => _MyAuthScreenState();
}

class _MyAuthScreenState extends State<MyAuthScreen> {



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
    String newPhotoUrl =  user.photoUrl.toString();
    String tempEmail = user.email.toString();

    setUserName(tempName);
    setProfilePicture(newPhotoUrl);
    setEmailAddress(tempEmail);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print(getId().toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tempId = prefs.getInt("id");
    print("temp id: " + tempId.toString());
    getData();

    bool inDatabase = false;
    for(int i = 0; i < profileList.length; i++)
      {
        String tempEmailAddress = profileList[i]["email"];
        print(tempEmailAddress);
        //print(user.email);
        print(i);
        if(tempEmailAddress == user.email){
          inDatabase = true;
        }
      }

    if(!inDatabase && tempId == null) {

      NewUser tempUser = NewUser(name: tempName, email: tempEmail);

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

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              InitialAddressForm(
                  emailAddress))); // Should be changed to AuthScreen.dart which should go to InitialAddressForm.dart
    }
    else
      {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              MainScreen()));

          _LoggedIn();

      }
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
                //emailAddress = getEmailAddress();
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
    String updateUrl = 'http://10.0.2.2:8080/rides/profile/new';
    final response = await http.post('$updateUrl',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: ''
        },
        body: userToJson(user)
    );
    return response;
  }

  Future<void> _LoggedIn() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logged In!', textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Welcome Back ' + getUserName() + '!', textAlign: TextAlign.center, style: TextStyle(color: Colors.blue), ),
                Text(' '),
                Container(
                    margin: EdgeInsets.only(
                        bottom: 0.0, left: 30.0, right: 30.0, top: 0.0),
                    width: 110.0,
                    height: 150.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            // This is where we would retrieve the image from the data base
                            image: NetworkImage(getProfilePic())))),
                Text(' '),
                Text(getEmailAddress(), textAlign: TextAlign.center, style: TextStyle(color: Colors.blue), ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Post>> getAllPost() async {
    String postUrl = 'http://10.0.2.2:8080/rides/profile/all';
    final response = await http.get(postUrl);
    return allPostsFromJson(response.body);
  }

  Future<List<Post>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(

      /// Change the URL to the end point from the database
        Uri.encodeFull('http://10.0.2.2:8080/rides/profile/all'),
        headers: {"Accept": "application/json"});

    this.setState(() {
      profileList = json.decode(response.body);
    });

    return allPostsFromJson(response.body);
  }


  setUserId(int newId) async {
    if (newId != null && newId != 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("id", newId);
      //print(newId);
      id = newId;
    }
  }

  Future<int> getMyUserId() async {
    String addressUrl = 'http://10.0.2.2:8080/rides/profile/getmyid/$emailAddress';
    final response2 = await http.get(addressUrl);
    var res = response2.body;
    await setUserId(int.parse(res));
    print(res);
    return int.parse(res);
  }

/*
  Future<http.Response> createAddress(AddressPost address) async {
    String userId = getId();
    print(userId);
    String updateUrl = 'http://10.0.2.2:8080/rides/address/$userId/new';
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

