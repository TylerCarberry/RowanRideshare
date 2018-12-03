import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AuthScreen.dart';
import 'ChatroomModel.dart';
import 'Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
List<String> messages = ["1 Hey!", "2 Hello!", "1 How are you"];
Map<String,dynamic> profileChats;

getProfiles() {
  return profileChats;
}
class ChatRoomScreen extends StatefulWidget {
  @override
  ChatRoomScreenState createState() => new ChatRoomScreenState();
}
class ChatRoomScreenState extends State<ChatRoomScreen> {
  /**
   * This Widget is the ChatRooms - People who are in contact with the user
   *
   *
   */
  Future<ChatList> getData() async {
    int userId = await getId();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.get(
      /// Change the URL to the end point from the database
        Uri.encodeFull(BASE_URL + '/rides/profile/$userId/chatrooms'),
        headers: {"Accept": "application/json"});
    print(json.decode(response.body));
    
    this.setState(() {
      profileChats = json.decode(response.body);
    });

    print(profileChats);

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
        appBar: AppBar(title: Text('Messages'), centerTitle: true),
        drawer: launchAppDrawer(context),
        body: ListView.builder(
          itemCount: profileChats == null ? 0 : profileChats.length,
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://s3.amazonaws.com/nvest/Blank_Club_Website_Avatar_Gray.jpg"),
              ),
              title: Text(profileChats["chatrooms"][index]["profileNames"]["Profile 2"].toString()),//name
              subtitle: Text(
                  profileChats["chatrooms"][index]["messages"][profileChats["chatrooms"][index]["messages"].length -1]["text"]),

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
      if (_textController.text.isEmpty) {} else
        messages..insert(0, _textController.text);
    });
    _textController.clear();
  }
  /**
   * This Widget is where the user actually writes the message
   */
  Widget MessageContainer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme
            .of(context)
            .accentColor),
        child: new Container(
          //modified
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: _afterMessageSubmission,
                  decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () {
                      _afterMessageSubmission(_textController.text);
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
            title: Text("Tapan Soni"),
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
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemCount: messages == null ? 0 : messages.length,
                // todo - change this to get the length of the chat room
                /// REMOVE THE BUILD CONTEXT - ONLY THERE FOR TESTING
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: Row(
                          children: messages[index].substring(0, 1) == '1'
                              ? rightSide(index)
                              : leftSide(index)));
                  // TODO -- CHANGE THE LOGIC SO IT COMPARES USERid from shared preferences WITH SENDERid
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
                child: MessageContainer(),
                decoration:
                new BoxDecoration(color: Theme
                    .of(context)
                    .cardColor))
          ],
        ));
  }
  /**
   * This method shifts the message to the right hand side - used when the user
   * types in their message
   */
  List<Widget> rightSide(int index) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
//            Text(messages[index], style: TextStyle(
//                fontSize: 18.0,
//                fontWeight: FontWeight.bold
//            )),
            new Container (
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data.chatrooms[0].messages[1].text.toString());
                            return Text('${snapshot.data.chatrooms[0].messages[0].text.toString()}', style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ) );
                          } else
                            return CircularProgressIndicator();
                        }))),
            new Container (
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data.chatrooms[0].messages[1].timeSent.toString());
                            return Text('${snapshot.data.chatrooms[0].messages[1].timeSent.toString()}', style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal
                            ) );
                          } else
                            return CircularProgressIndicator();
                        }))),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
              child: new CircleAvatar(
                backgroundImage:
                NetworkImage(
                    "http://s3.amazonaws.com/nvest/Blank_Club_Website_Avatar_Gray.jpg"),
              )),
        ],
      )
    ];
  }
  /**
   * This method shifts the message to the left hand side - used when receiving
   * a message
   */
  List<Widget> leftSide(int index) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: new CircleAvatar(
                backgroundImage:
                NetworkImage(
                    "http://s3.amazonaws.com/nvest/Blank_Club_Website_Avatar_Gray.jpg"),
              )),
        ],
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container (
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data.chatrooms[0].messages[1].text.toString());
                            return Text('${snapshot.data.chatrooms[0].messages[1].text.toString()}', style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold
                            ) );
                          } else
                            return CircularProgressIndicator();
                        }))),
            new Container (
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data.chatrooms[0].messages[1].timeSent.toString());
                            return Text('${snapshot.data.chatrooms[0].messages[1].timeSent.toString()}', style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal
                            ) );
                          } else
                            return CircularProgressIndicator();
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
//  print(userid);
  String postUrl = BASE_URL + '/rides/profile/4/chatrooms';
  final response = await http.get(postUrl);
  print(listFromJsonChat(response.body));
  return listFromJsonChat(response.body);
}