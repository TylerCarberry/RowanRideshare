import 'package:flutter/material.dart';

import 'RideScreen.dart';
import 'editschedule.dart';
import 'main.dart';
import 'profile.dart';
import 'AppDrawer.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  ChatRoomScreenState createState() => new ChatRoomScreenState();
}

class ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Messages'), centerTitle: true),
        drawer: launchAppDrawer(context),
        body: ListView.builder(
          itemCount: 5,
          // profile == null ? 0 : chatrooms.length
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://s3.amazonaws.com/nvest/Blank_Club_Website_Avatar_Gray.jpg"),
              ),
              title: Text("Firstname Lastname"), // TODO - Pull name from DB
              // TODO -- Pull the name using the index
              // profile[index]["name"]
              onTap: () {

                print("Hello World");

//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => ChatThread(context, index)));
              },
            );
          },
        ));
  }
}