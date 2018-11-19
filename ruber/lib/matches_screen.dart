import 'package:flutter/material.dart';
import 'package:ruber/AppDrawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async' show Future;
import 'ProfileModel.dart';

import 'dart:io';
List profileMatches;

getProfile() {
  return profileMatches;
}

class matchesScreen extends StatefulWidget {
  @override
  matchesScreenState createState() => new matchesScreenState();
}

class matchesScreenState extends State<matchesScreen> {
  Future<String> getData() async {
    var response = await http.get(

        /// Change the URL to the end point from the database
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      profileMatches = json.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Widget expandProfile(BuildContext context, int index) {
    return Scaffold(
        appBar: AppBar(
          title: Text(profileMatches[index]["title"]), // Name of the person
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
                child: Center(child: Text('Firstname Lastname')),
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

              Container(child: Center(child: Text('blah@random.com'))),

              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Joined Date',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontFamily: 'Helvetica',
                    color: Colors.teal,
                  ),
                ),
              ),

              Container(child: Center(child: Text('6/6/6'))),

              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Distance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontFamily: 'Helvetica',
                    color: Colors.deepPurpleAccent
                  ),
                )
              ),

              Container(child: Center(child: Text("4.34 miles"))),

              Container(
                margin: EdgeInsets.only(top: 20.0),
                  child: Center(
                      child: RaisedButton(
                child: Text('Send Ride Request!'),
                        onPressed: () {
                  print("hello!");
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
                title: Text("Firstname Lastname"),
                subtitle: Text(profileMatches[index]["title"]),
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
  String postUrl = 'http://e7dfbe04.ngrok.io/rides/matching/3/20';
  final response = await http.get(postUrl);
  return allPostsFromJson(response.body);
}
