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

Map<String, dynamic> profileChats;
String myInputText;

int chatRoomId;

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

class ChatRoomScreenState extends State<ChatRoomScreen> {
  /**
   * This Widget is the ChatRooms - People who are in contact with the user
   */
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

  /// MESSAGE INPUT CONTAINER TEXTCONTROLLER
  TextEditingController _textController = new TextEditingController();

  void _afterMessageSubmission(String text) {
    setState(() {
      if (_textController.text.isEmpty) {
      } else
//        messages..insert(0, _textController.text);
        setMyInputText(_textController.text);
    });
    //_textController.clear();
  }

  /**
   * This Widget is where the user actually writes the message
   */
  Widget MessageContainer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          //modified
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

  /**
   * This is the screen that is shown when the user clicks on another user in the
   * main Chat Room
   */
  Widget IndividualChatThread(BuildContext context, int index) {
    return Scaffold(
        appBar: AppBar(
            title: Text(profileChats["chatrooms"][index]["profileNames"]
                        ["Profile 2"]
                    .toString() +
                " & " +
                profileChats["chatrooms"][index]["profileNames"]["Profile 1"]
                    .toString()),
            // TODO - Grab from the db using the index
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IndividualChatThread(context, index)));
                  })
            ]),
        // TODO: Name should be pulled using the index or the profile ID
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

  /**
   * This method shifts the message to the right hand side - used when the user
   * types in their message
   */
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

  /**
   * This method shifts the message to the left hand side - used when receiving
   * a message
   */
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
  String postUrl = BASE_URL + '/rides/profile/$userid/chatrooms';
  final response = await http.get(postUrl);
//  print(listFromJsonChat(response.body));
  return listFromJsonChat(response.body);
}

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