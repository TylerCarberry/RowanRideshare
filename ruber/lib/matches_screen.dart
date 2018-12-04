import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ruber/AppDrawer.dart';
import 'package:ruber/Constants.dart';

import 'ProfileModel.dart';

import 'main.dart';
import 'dart:async' show Future;
import 'ChatroomModel.dart';
import 'ProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
List profileMatches;


getId() async {
  int id;
  if(id == 0 || id == null)
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt("id");
  };
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

        /// Change the URL to the end point from the database
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

  Widget expandProfile(BuildContext context, int index) {
    return Scaffold(
        appBar: AppBar(
          title: Text(profileMatches[index]["name"]), // Name of the person
          centerTitle: true,
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              /// User image: avatar
              Container(
                  margin: EdgeInsets.only(
                      bottom: 0.0, left: 90.0, right: 90.0, top: 0.0),
                  width: 180.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          // This is where we would retrieve the image from the data base
                          image: NetworkImage(
                              "http://s3.amazonaws.com/nvest/Blank_Club_Website_Avatar_Gray.jpg")))),

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

              Container(child: Center(child: Text(profileMatches[index]["email"]))),

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

              Container(child: Center(child: Text(profileMatches[index]["distanceRounded"].toString() + " miles"))),

              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Center(
                      child: RaisedButton(
                child: Text('Send Ride Request!'),
                        onPressed: () {
                  //create new chatroom
                          //change end line 151
//                          int id1 = getId();
//                          print(id1);
                          String matchEmail = profileMatches[index]["email"];
                          getMatchesId(matchEmail);

//                  ProfileIDs ids = new ProfileIDs(profileOneID: 4, profile2: 287);
//                  print(ids);
                  ChatRoom newRoom = new ChatRoom(profileOneID: getMyId(), profileTwoID: getMatchIdInt());
                          createChatRoom(newRoom).then((response) {
                            if (response.statusCode > 200)
                              print(response.body);
                            else
                              print(response.statusCode);
                          }).catchError((error) {
                            print('error : $error');
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessagesScreen()));
                        },
              )))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Matches'), centerTitle: true),
        drawer: launchAppDrawer(context),
        body: ListView.builder(
            itemCount: profileMatches == null ? 0 : profileMatches.length,
            itemBuilder: (BuildContext context, int index) {
              return new ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "http://s3.amazonaws.com/nvest/Blank_Club_Website_Avatar_Gray.jpg")),
                title: Text(profileMatches[index]["name"]),
                subtitle: Text(
                    profileMatches[index]["distanceRounded"].toString() +

                        " miles                    " + profileMatches[index]["schedulesString"].toString()),

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

getMatchIdInt(){
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
getMyProfileId() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int tempId = prefs.getInt("id");
  if (tempId != 0 && tempId != null) {
    id = tempId;
  }

  return id;
}

getMyId(){
  return id;
}