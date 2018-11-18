import 'package:flutter/material.dart';
import 'package:ruber/AppDrawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
                  width: 190.0,
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
