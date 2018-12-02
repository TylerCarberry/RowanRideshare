import 'package:flutter/material.dart';

import 'AppDrawer.dart';

List<String> messages = [
  "1 Hey!",
  "2 Hello!",
  "1 How are you"
];

class ChatRoomScreen extends StatefulWidget {
  @override
  ChatRoomScreenState createState() => new ChatRoomScreenState();
}

class ChatRoomScreenState extends State<ChatRoomScreen> {
  /**
   * This Widget is the ChatRooms - People who are in contact with the user
   */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Messages'), centerTitle: true),
        drawer: launchAppDrawer(context),
        body: ListView.builder(
          itemCount: 4,
          // profile == null ? 0 : chatrooms.length
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "http://s3.amazonaws.com/nvest/Blank_Club_Website_Avatar_Gray.jpg"),
              ),
              title: Text("Tapan Soni"), // TODO - Pull name from DB
              // TODO -- Pull the name using the index
              // profile[index]["name"]
              onTap: () {
                print("Hello World");
//                print(chat[index]["chatrooms"].messages[index]);

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
      if(_textController.text.isEmpty){}
      else
        messages..insert(0, _textController.text);
    });

    _textController.clear();
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
                itemCount: messages == null ? 0: messages.length,

                /// REMOVE THE BUILD CONTEXT - ONLY THERE FOR TESTING
                itemBuilder: (BuildContext context, int index) {
                  return new ListTile(
                    title: Text(messages[index]),
                    // TODO - Pull name from DB
                    // TODO -- Pull the name using the index
                    // profile[index]["name"]
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  IndividualChatThread(context, index)));
                    },
                  );
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
                child: MessageContainer(),
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor))
          ],
        ));
  }
}
