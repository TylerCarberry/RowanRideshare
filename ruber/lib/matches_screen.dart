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
                        " miles" + ["schedulesString"].toString()),
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
  String postUrl = BASE_URL + '/rides/matching/3/20';
  final response = await http.get(postUrl);
  return allPostsFromJson(response.body);
}
