/// ChatRoomScreen.dart
///
/// Purpose:
/// This file is used to show the different chat threads once the user
/// clicks on the "Messages" option from the main menu. It also includes
/// the screen which allows the user to type in a message and send it
/// to the opposing user.

/// Imports
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'AppDrawer.dart';
import 'AuthScreen.dart';
import 'ChatroomModel.dart';
import 'Constants.dart';

/// Global variables for storing the chat rooms from the server

Map<String, dynamic> profileChats;
String myInputText;

int chatRoomId;

/// Getter and setter methods

getChatRoomId() {
  return chatRoomId;
}

setChatRoomId(int tempID) {
  chatRoomId = tempID;
}

getProfiles() {
  return profileChats;
}

getMyInputText() {
  return myInputText;
}

setMyInputText(String tempInput) {
  myInputText = tempInput;
}

class ChatRoomScreen extends StatefulWidget {
  @override
  ChatRoomScreenState createState() => new ChatRoomScreenState();
}

/// ChatRoomScreenState class holds all the Widgets for the chat room
/// functionality.
/// Widgets in ChatRoomScreenState:
/// Chat Threads Screen - build()
///
class ChatRoomScreenState extends State<ChatRoomScreen> {

  int index;
  Future<ChatList> getData() async {
    int userId = await getId();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.get(

        /// Change the URL to the end point from the database
        Uri.encodeFull(BASE_URL + '/rides/profile/$userId/chatrooms'),
        headers: {"Accept": "application/json"});

    this.setState(() {
      profileChats = json.decode(response.body);
    });

    return listFromJsonChat(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  /// Chat Thread screen -- initial screen which is shown whenever
  /// the user clicks on the "Messages" option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
          centerTitle: true,
        ),
        drawer: launchAppDrawer(context),
        body: ListView.builder(
          itemCount:
              profileChats == null ? 0 : profileChats["chatrooms"].length,
          itemBuilder: (BuildContext context, int index) {
            int chatid = profileChats["chatrooms"][index]["chatRoomId"];
            setChatRoomId(chatid);
            return new ListTile(
              leading: Container(
                  margin: EdgeInsets.only(
                      bottom: 5.0, left: 5.0, right: 5.0, top: 5.0),
                  width: 40.0,
                  height: 50.0,
                  child: new CircleAvatar(
                      child: new Text(
                    profileChats["chatrooms"][index]["profileNames"]
                                ["Profile 2"]
                            .toString()
                            .substring(0, 1) +
                        profileChats["chatrooms"][index]["profileNames"]
                                ["Profile 1"]
                            .toString()
                            .substring(0, 1),
                    style: TextStyle(fontSize: 20),
                  ))),
              title: Text(profileChats["chatrooms"][index]["profileNames"]
                          ["Profile 2"]
                      .toString() +
                  " & " +
                  profileChats["chatrooms"][index]["profileNames"]["Profile 1"]
                      .toString()),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            IndividualChatThread(context, index)));
              },
            );
          },
        ));
  }

  /// Text Editing Controller - for holding the message that was typed

  TextEditingController _textController = new TextEditingController();

  void _afterMessageSubmission(String text) {
    setState(() {
      if (_textController.text.isEmpty) {
      } else
        setMyInputText(_textController.text);
    });
  }

  /// This widget holds the different messages from both parties - also
  /// shows the time sent/received and their profile image

  Widget MessageContainer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: _afterMessageSubmission,
                  onSubmitted: _afterMessageSubmission,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 8.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () {
                      String newText = getMyInputText();
                      Messages newMessage = Messages(
                          chatroomID: getChatRoomId(),
                          senderID: id,
                          text: newText);
                      createMessage(newMessage).then((response) {
                        if (response.statusCode > 200)
                          print(response.body);
                        else
                          print(response.statusCode);

                        getData().then((res) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      IndividualChatThread(context, index)));
                        });

                      }).catchError((error) {
                        print('error : $error');
                      });
                      _textController.clear();
                    }),
              ),
            ],
          ),
        ));
  }

  /// This is the screen shown when the user clicks onto a chat thread
  /// in the chat room screen. It holds the MessageContainer inside it
  /// so that it can show the different messages being typed

  Widget IndividualChatThread(BuildContext context, int index) {
    this.index = index;
    return Scaffold(
        appBar: AppBar(
            title: Text(profileChats["chatrooms"][index]["profileNames"]
                        ["Profile 2"]
                    .toString() +
                " & " +
                profileChats["chatrooms"][index]["profileNames"]["Profile 1"]
                    .toString()),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {

                    getData().then((res) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  IndividualChatThread(context, index)));
                    });

                  })

            ]),
        drawer: launchAppDrawer(context),
        body: new Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: new EdgeInsets.all(15.0),
                reverse: true,
                itemCount: profileChats == null
                    ? 0
                    : profileChats["chatrooms"][index]["messages"].length,
                itemBuilder: (BuildContext context, int index2) {
                  return Container(

                    /// This logic decides where the messages go in the
                    /// MessageContainer - right or left. Right is for the
                    /// sender, left is for the received messages. It does
                    /// this by comparing the senderID of the message being
                    /// sent to the profileID of the user of the app. If they
                    /// are equal, then it means that the sender is the user
                    /// so it goes on the right hand side, and ANY other message
                    /// goes on the left hand side (receiver messages)

                      child: Row(
                          children: profileChats["chatrooms"][index]["messages"]
                                      [index2]["senderID"] ==
                                  id
                              ? rightSide(index, index2)
                              : leftSide(index, index2)));
                },
              ),
            ),
            Divider(height: 0.0),
            Container(
                child: MessageContainer(),
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor))
          ],
        ));
  }

  /// This is for structuring the message to go on the right side, if
  /// the message is being sent by the user of the app - currently
  /// Received messages from the other party are displayed on the left
  /// hand side

  List<Widget> rightSide(int index, int index2) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          return Text(
                              profileChats["chatrooms"][index]["messages"]
                                      [index2]["text"]
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold));
                        }))),
            new Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          return Text(
                              profileChats["chatrooms"][index]["messages"]
                                      [index2]["timeSent"]
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal));
                        }))),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
              margin:
                  EdgeInsets.only(bottom: 0.0, left: 5.0, right: 5.0, top: 0.0),
              width: 42.0,
              height: 38.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      // This is where we would retrieve the image from the data base
                      image: NetworkImage(userProfilePic)))),
        ],
      )
    ];
  }

  /// This is used to structure the message on the left hand side -- for
  /// received messages. Sent messages are displayed on the right hand side.

  List<Widget> leftSide(int index, int index2) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin:
                  EdgeInsets.only(bottom: 0.0, left: 0.0, right: 5.0, top: 0.0),
              width: 40.0,
              height: 50.0,
              child: new CircleAvatar(
                  child: new Text(
                profileChats["chatrooms"][index]["profileNames"]["Profile 2"]
                    .toString()
                    .substring(0, 1),
                style: TextStyle(fontSize: 20),
              ))),
        ],
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          return Text(
                              profileChats["chatrooms"][index]["messages"]
                                      [index2]["text"]
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold));
                        }))),
            new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          return Text(
                              profileChats["chatrooms"][index]["messages"]
                                      [index2]["timeSent"]
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal));
                        }))),
          ],
        ),
      )
    ];
  }
}

/*
* This method is used to get the users Id from shared Preferences
 */
getId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int tempId = prefs.getInt("id");
  if (tempId != 0 && tempId != null) {
    id = tempId;
  }
  return id;
}
/*
* This Method is used to return all of the chatrooms the user is part of.
 */
Future<ChatList> getChatrooms() async {
  int userid = await getId();
  String postUrl = BASE_URL + '/rides/profile/$userid/chatrooms';
  final response = await http.get(postUrl);
  return listFromJsonChat(response.body);
}
/*
*This method is used to post messages to the server.
 */
Future<http.Response> createMessage(Messages myMessage) async {
  String newMessageUrl = BASE_URL + '/rides/message/new';
  final response = await http.post('$newMessageUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: messagePostToJson(myMessage));
  return response;
}
