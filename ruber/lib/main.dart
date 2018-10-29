import 'package:flutter/material.dart';
import 'login.dart';
import 'RideScreen.dart';
import 'AppDrawer.dart';
import 'profile.dart';
import 'Messages_Screen.dart';
import 'settings_Screen.dart';
import 'MapPage.dart';
import 'package:map_view/map_view.dart';
import 'StaticMapPage.dart';

var api_key = "AIzaSyDrHKl8IxB4cGXIoELXQOzzZwiH1xtsRf4";

const String _name = "Your Name";

void main() {
  MapView.setApiKey(api_key);
  runApp(MaterialApp(
    title: 'RUber',
    home: MainScreen(),
  ));
}

class MainScreen extends StatelessWidget {
  final String title;
  MainScreen ({Key key, this.title}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RUber'),
          centerTitle: false,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
              children: [
//              Container(child: StaticMapPage(), height: 381.0),
                RaisedButton(
                  child: Text('New Ride'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewRideScreen()),
                    );
                  },
                ),
                RaisedButton(
                    child: Text('Messages'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MessagesScreen()),
                      );
                    }),
                RaisedButton(
                    child: Text('Profile'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    }),
                RaisedButton(
                    child: Text('Settings'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsScreen()),
                      );
                    }),
                RaisedButton(
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TextForm()),
                      );
                    }),
                RaisedButton(
                    child: Text('Map Test'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()),
                      );
                    }),

              ]
          ),
        ));
  }
}

// ==================== LOGIN SCREEN ======================== //

class TextForm extends StatefulWidget {
  _TextForm createState() => _TextForm();
}

class _TextForm extends State<TextForm> {

  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController1 = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget build(context) {
    return launchLoginScreen(myController, myController1, myController2, myController3, context);
  }
}


// =================END LOGIN SCREEN ======================== //


// ================== MESSAGES SCREEN ======================= //

class MessagesScreen extends StatefulWidget {
  State createState() => MessagesScreenState();
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return launchChatMessageContainer(context, text, _name);
  }
}

class MessagesScreenState extends State<MessagesScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
    );

    // TODO: Why is this an error??

//    setState(() {
//      _messages.insert(0, message);
//    }
//      );

  }


  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme
            .of(context)
            .accentColor),
        child: new Container( //modified
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration: new InputDecoration.collapsed(
                      hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text)),
              ),
            ],
          ),
        )
    );
  }

  Widget build(BuildContext context) {
    return launchMessagesScreen(context, _messages, _buildTextComposer);
  }
}

// ======================== END MESSAGES SCREEN ====================== //

class NewRideScreen extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(title: Text('New Ride'), centerTitle: true),
        drawer: launchAppDrawer(context),
        body: DefaultTabController(
            length: 2,
            child: launchRideScreen(context)
        )
    );
  }
}

class SettingsScreen extends StatelessWidget {
  Widget build(context) {
    return launchSettingsScreen(context);
  }
}
