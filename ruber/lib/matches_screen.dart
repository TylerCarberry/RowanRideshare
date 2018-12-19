/// matches_screen.dart
///
/// Purpose:
/// The purpose of this file is to show the matches found depending on the
/// radius set by the user. It shows the user name, the days matched, and
/// the distance they are away from the main user. It uses a listview builder
/// which is a dynamic list created using the length of the returned match
/// profiles JSON.

/// Imports
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ruber/AppDrawer.dart';
import 'package:ruber/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChatRoomScreen.dart';
import 'ChatroomModel.dart';
import 'ProfileModel.dart';

/// Variable where the returned matched profiles are stored
List profileMatches;

getId() async {
  int id;
  if (id == 0 || id == null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt("id");
  }
  ;
  return id;
}

getProfile() {
  return profileMatches;
}

class matchesScreen extends StatefulWidget {
  @override
  matchesScreenState createState() => new matchesScreenState();
}

class matchesScreenState extends State<matchesScreen> {
  Future<List<Post>> getData() async {
    int userId = await getId();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int radius = prefs.get("radius");
    var response = await http.get(
        Uri.encodeFull(BASE_URL + '/rides/matching/$userId/$radius'),
        headers: {"Accept": "application/json"});

    this.setState(() {
      profileMatches = json.decode(response.body);
    });

    return allPostsFromJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  /// This is the widget which is called on when the user clicks a match
  /// It shows the full profile (without address), to the user and it
  /// allows the user to send them a ride request

  Widget expandProfile(BuildContext context, int index) {
    return Scaffold(
        appBar: AppBar(
          title: Text(profileMatches[index]["name"]), // Name of the person
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      bottom: 0.0, left: 90.0, right: 90.0, top: 15.0),
                  width: 150.0,
                  height: 160.0,
                  child: new CircleAvatar(
                      child: new Text(
                    profileMatches[index]["name"].toString().substring(0, 1),
                    style: TextStyle(fontSize: 65),
                  ))),

              /// Full Name

              Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Text('Full Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          fontFamily: 'Helvetica',
                          color: Colors.blueAccent))),

              Container(
                child: Center(child: Text(profileMatches[index]["name"])),
              ),

              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text('Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Helvetica',
                        color: Colors.deepOrange)),
              ),

              Container(
                  child: Center(child: Text(profileMatches[index]["email"]))),

              Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Distance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Helvetica',
                        color: Colors.deepPurpleAccent),
                  )),

              Container(
                  child: Center(
                      child: Text(
                          profileMatches[index]["distanceRounded"].toString() +
                              " miles"))),

              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Center(
                      child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Send Ride Request!'),
                    onPressed: () {
                      String matchEmail = profileMatches[index]["email"];
                      getMatchesId(matchEmail).then((otherId) {
                        getMyProfileId().then((myId) {
                          print(myId);
                          ChatRoom newRoom = new ChatRoom(
                              profileOneID: myId, profileTwoID: otherId);
                          createChatRoom(newRoom).then((response) {
                            if (response.statusCode > 200)
                              print(response.body);
                            else
                              print(response.statusCode);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatRoomScreen()));
                          }).catchError((error) {
                            print('error : $error');
                          });
                        }).catchError((error) {
                          print('unable to get id. error : $error');
                        });
                      });
                    },
                  )))
            ],
          ),
        ));
  }

  /// This is the main widget that is displayed. It shows a dynamically
  /// created list based on the profilematches list. It shows the
  /// name, distance, and matched day.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Matches'), centerTitle: true),
        drawer: launchAppDrawer(context),
        body: ListView.builder(
            itemCount: profileMatches == null ? 0 : profileMatches.length,
            itemBuilder: (BuildContext context, int index) {
              return new ListTile(
                leading: Container(
                    margin: EdgeInsets.only(
                        bottom: 0.0, left: 5.0, right: 5.0, top: 0.0),
                    width: 40.0,
                    height: 50.0,
                    child: new CircleAvatar(
                        child: new Text(
                      profileMatches[index]["name"].toString().substring(0, 1),
                      style: TextStyle(fontSize: 20),
                    ))),
                title: Text(profileMatches[index]["name"]),
                subtitle: Text(
                    profileMatches[index]["distanceRounded"].toString() +
                        " miles                    " +
                        profileMatches[index]["schedulesString"].toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => expandProfile(context, index)));
                },
              );
            }));
  }
}

Future<List<Post>> getAllPost() async {
  int userId = await getId();
  String postUrl = BASE_URL + '/rides/matching/$userId/20';
  final response = await http.get(postUrl);
  return allPostsFromJson(response.body);
}

Future<http.Response> createChatRoom(ChatRoom chatroom) async {
  int userId = await getId();
  //print(userId);
  String newMessageUrl = BASE_URL + '/rides/chatroom/new';
  final response = await http.post('$newMessageUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: chatroomPostToJson(chatroom));
  print(response.body);
  return response;
}

Future<http.Response> createMessage(Messages message) async {
  int userId = await getId();
  String newMessageUrl = BASE_URL + '/rides/message/new';
  final response = await http.post('$newMessageUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: messagePostToJson(message));
  print(response.body);
  return response;
}

Future<int> getMatchesId(String tempEmail) async {
  String addressUrl = BASE_URL + '/rides/profile/getmyid/$tempEmail';
  final response2 = await http.get(addressUrl);
  var res = response2.body;
  await setMatchId(int.parse(res));
  print(res);
  return int.parse(res);
}

int matchId;

getMatchId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int tempId = prefs.getInt("matchID");
  if (tempId != 0 && tempId != null) {
    matchId = tempId;
  }

  return matchId;
}

getMatchIdInt() {
  return matchId;
}

setMatchId(int newId) async {
  if (newId != null && newId != 0) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("matchID", newId);
    //print(newId);
    matchId = newId;
  }
}

int id;

Future<int> getMyProfileId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int tempId = prefs.getInt("id");
  if (tempId != 0 && tempId != null) {
    id = tempId;
  }

  return id;
}

getMyId() {
  return id;
}
