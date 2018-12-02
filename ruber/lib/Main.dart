import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ruber/AuthScreen.dart';

import 'AuthScreen.dart';
import 'Login.dart';
import 'Messages_Screen.dart';
import 'RideScreen.dart';
import 'editschedule.dart';
import 'profile.dart';
import 'settings_Screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

var api_key = "AIzaSyDrHKl8IxB4cGXIoELXQOzzZwiH1xtsRf4";
const String _name = "Your Name";

void main() => runApp(new RUber());

class RUber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'RUber', home: WelcomeScreen());
  }
}

// ==================== WELCOME SCREEN ====================== //

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to RUber'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'RUber',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 48.0),
                ),
              ),
              Image.network(
                'https://www.tlcrentalmarketplace.com/wp-content/uploads/2018/03/rideshare.png', height: 150,
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0, bottom: 15.0),
                child: Text(
                  'Exclusively for Rowan University students\n\n Commute with other students near you\n\n Match based on class schedule and distance\n\n Save gas and the planet!'
                  ,style: TextStyle(color: Colors.black, fontSize: 18.0,  ),textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                child: Text("Continue", style: TextStyle(fontSize: 19),),
                textColor: Colors.white,
                color: Colors.blue,
                minWidth: 200.0,
                height: 100.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyAuthScreen())); // Should be changed to AuthScreen.dart which should go to InitialAddressForm.dart
                },
              ),
/*              MaterialButton(
                child: Text(" ", style: TextStyle(fontSize: 19),),
                textColor: Colors.white,
                minWidth: 200.0,
                height: 50.0,
              ),*/
            ],
          ),
        ));
  }
}

// =========================== END WELCOME SCREEN ====================== //

class MainScreen extends StatelessWidget {
  final String title;

  MainScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RUber'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(children: [
            RaisedButton(
              child: Text('New Ride'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => launchRideScreen()),
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                }),
            RaisedButton(
              child: Text('Schedule'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScheduleForm()));
              },
            ),
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
                    MaterialPageRoute(builder: (context) => MyAuthScreen()),
                  );
                }),
          ]),
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
    return launchLoginScreen(
        myController, myController1, myController2, myController3, context);
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

    ChatMessage message = new ChatMessage(text: text);

    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
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
                  onSubmitted: _handleSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
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
        ));
  }

  Widget build(BuildContext context) {
    return launchMessagesScreen(context, _messages, _buildTextComposer);
  }
}

// ======================== END MESSAGES SCREEN ====================== //

class SettingsScreen extends StatelessWidget {
  Widget build(context) {
    return launchSettingsScreen(context);
  }
}
