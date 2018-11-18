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
              Container(
                child: Text("Hello")
              )
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
                subtitle: Text("4.3 miles away"),
                onTap: () {
//                  expandProfile(context, index);

                  Navigator.push(context, MaterialPageRoute(builder: (context) => expandProfile(context, index)));
                },
              );
            }));
  }
}
