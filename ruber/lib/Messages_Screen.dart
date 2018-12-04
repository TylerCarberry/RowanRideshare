import 'package:flutter/material.dart';

import 'AppDrawer.dart';
import 'ChatroomModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ruber/Constants.dart';
import 'package:http/http.dart' as http;
import 'AuthScreen.dart';
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';
int id;

Container launchChatMessageContainer(context, text, _name) {
  return new Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: new CircleAvatar(child: new Text(getUserName().toString().substring(0,1))),
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(getUserName(), style: Theme.of(context).textTheme.subhead),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Container(
                  child: Center(
                      child: FutureBuilder<ChatList>(
                          future: getChatrooms(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data.chatrooms[0].messages[1].text.toString());
                              return Text('${snapshot.data.chatrooms[0].messages[1].text.toString()}');
                            } else
                              return CircularProgressIndicator();
                          }))),
            ),
          ],
        ),
      ],
    ),
  );
}

Scaffold launchMessagesScreen(context, _messages, _buildTextComposer) {
  return new Scaffold(
    appBar: new AppBar(title: new Text("Messages")),
    drawer: launchAppDrawer(context),
    body: new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),

      ],
    ),
  );
}

getId() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int tempId = prefs.getInt("id");
  if (tempId != 0 && tempId != null) {
    id = tempId;
  }

  return id;
}

Future<ChatList> getChatrooms() async {
  int userid = await getId();
//  print(userid);
  String postUrl = BASE_URL + '/rides/profile/2/chatrooms';
  final response = await http.get(postUrl);
  print(listFromJsonChat(response.body));
  return listFromJsonChat(response.body);
}

