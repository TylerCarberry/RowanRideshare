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
import 'dart:io';


//List<String> messages = ["1 Hey!", "2 Hello!", "1 How are you"];
Map<String,dynamic> profileChats;
String myInputText;

int chatRoomId;

getChatRoomId(){
  return chatRoomId;
}

setChatRoomId(int tempID){
  chatRoomId = tempID;
}

getProfiles() {
  return profileChats;
}

getMyInputText(){
  return myInputText;
}

setMyInputText(String tempInput){
  myInputText = tempInput;
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
//    print(json.decode(response.body));
    
    this.setState(() {
      profileChats = json.decode(response.body);
    });

//    print(profileChats);

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
          itemCount: profileChats == null ? 0 : profileChats["chatrooms"].length,
          itemBuilder: (BuildContext context, int index) {
            int chatid = profileChats["chatrooms"][index]["chatRoomId"];
//            print(chatid);
            setChatRoomId(chatid);
//            print(chatid);
//            print(getChatRoomId());
            return new ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://s3.amazonaws.com/nvest/Blank_Club_Website_Avatar_Gray.jpg"),
              ),

              title: Text(profileChats["chatrooms"][index]["profileNames"]["Profile 2"].toString()),

            //name}
//              subtitle: Text(
//                  profileChats["chatrooms"][index]["messages"][profileChats["chatrooms"][index]["messages"].length -1]["text"]),

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
//        messages..insert(0, _textController.text);
      setMyInputText(_textController.text);
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
                      String newText = getMyInputText();
//                      print(id);
//                      print(getChatRoomId());
                      Messages newMessage = Messages(chatroomID: getChatRoomId(), senderID: id,text: newText);
//                      print(newText);
//                      print(newMessage.text.toString());
                      createMessage(newMessage).then((response) {
                        if (response.statusCode > 200)
                          print(response.body);
                        else
                          print(response.statusCode);
                      }).catchError((error) {
                        print('error : $error');
                      });



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
//            title: Text(profileChats["chatrooms"][index]["messages"].length.toString()),
            title: Text(profileChats["chatrooms"][index]["profileNames"]["Profile 1"].toString()),
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

                itemCount: profileChats == null ? 0 : profileChats["chatrooms"][index]["messages"].length,

                // todo - change this to get the length of the chat room
                /// REMOVE THE BUILD CONTEXT - ONLY THERE FOR TESTING

                itemBuilder: (BuildContext context, int index2) {
                  return Container(
                      child: Row(
                          children: profileChats["chatrooms"][index]["messages"][index2]["senderID"] == id
                              ? rightSide(index, index2)
                              : leftSide(index, index2)));
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
  List<Widget> rightSide(int index, int index2) {
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
                          //                          if (snapshot.hasData) {
//                            print(snapshot.data.chatrooms[index].messages[index2].text.toString());
//                          print(id);
//                          print(profileChats["chatrooms"][index]["messages"][index2]["senderId"]);
                          return Text(profileChats["chatrooms"][index]["messages"][index2]["text"].toString(), style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold
                          ) );
//                          } else
//                            return CircularProgressIndicator();
                        }))),
            new Container (
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
                          //                          if (snapshot.hasData) {
//                            print(snapshot.data.chatrooms[index].messages[index2].timeSent.toString());
                          return Text(profileChats["chatrooms"][index]["messages"][index2]["timeSent"].toString(), style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal
                          ) );
//                          } else
//                            return CircularProgressIndicator();
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
  List<Widget> leftSide(int index, int index2) {
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
//                          if (snapshot.hasData) {
//                            print(snapshot.data.chatrooms[index].messages[index2].text.toString());
//                            print(index2);
//                          print(id);
//                          print(profileChats["chatrooms"][index]["messages"][index2]["senderId"]);
                            return Text(profileChats["chatrooms"][index]["messages"][index2]["text"].toString(), style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold
                            ) );
//                          } else
//                            return CircularProgressIndicator();
                        }))),
            new Container (
                margin: const EdgeInsets.only(top: 5.0),
                child: Container(
                    child: FutureBuilder<ChatList>(
                        future: getChatrooms(),
                        builder: (context, snapshot) {
//                          if (snapshot.hasData) {
//                            print(snapshot.data.chatrooms[index].messages[index2].timeSent.toString());
                            return Text(profileChats["chatrooms"][index]["messages"][index2]["timeSent"].toString(), style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal
                            ) );
//                          } else
//                            return CircularProgressIndicator();
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
  String postUrl = BASE_URL + '/rides/profile/$userid/chatrooms';
  final response = await http.get(postUrl);
//  print(listFromJsonChat(response.body));
  return listFromJsonChat(response.body);
}

Future<http.Response> createMessage(Messages myMessage) async {
  //int userId = await getId();
  //print(userId);
  String newMessageUrl = BASE_URL + '/rides/message/new';
  final response = await http.post('$newMessageUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: messagePostToJson(myMessage));
//  print(response.body);
  return response;
}

//int id;
//getMyProfileId() async{
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  int tempId = prefs.getInt("id");
//  if (tempId != 0 && tempId != null) {
//    id = tempId;
//  }
//
//  return id;
//}
//
//getMyId(){
//  return id;
//}