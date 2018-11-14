import 'package:flutter/material.dart';
import 'package:ruber/AuthScreen.dart';
import 'Login.dart';
import 'RideScreen.dart';
import 'AppDrawer.dart';
import 'profile.dart';
import 'Messages_Screen.dart';
import 'settings_Screen.dart';
import 'MapPage.dart';
import 'package:map_view/map_view.dart';

import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

var api_key = "AIzaSyDrHKl8IxB4cGXIoELXQOzzZwiH1xtsRf4";
const String _name = "Your Name";

//void main() {
//  MapView.setApiKey(api_key);
//  runApp(MaterialApp(
//    title: 'RUber',
//    home: Disclaimer(),
//  ));
//}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(title: 'RUber', home: Home(storage: Storage()));
  }
}

class Storage {
  // Get the local path
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  // Get the local file
  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/disclaimer.txt');
  }

  // Read the data
  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  // Write the data
  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}

class Home extends StatefulWidget {
  final Storage storage;

  Home({Key key, @required this.storage}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  String state;
  Future<Directory> _appDocDir;

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
  }

  Future<File> writeData() async {
    setState(() {
      state = controller.text;
      controller.text = "";
    });

    return widget.storage.writeData(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Disclaimer'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text('${state ?? "File is empty"}'),
            TextField(
              controller: controller,
            ),
            RaisedButton(
                onPressed: () {
                  writeData();
                },
                child: Text('Write to file'))
          ],
        )));
  }
}

// DISCLAIMER

class Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        const ListTile(
          contentPadding: EdgeInsets.only(top: 100.0, left: 70.0),
          title: Text('EULA Disclaimer'),
          subtitle: Text('We are not responsible for anything that happens'
              'from the use of this app to anyone or anything'),
        ),
        ButtonTheme.bar(
            child: Center(
                child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child: const Text('Accept and use'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MainScreen()) //Change this to AuthScreen()
                    );
              },
            )
          ],
        )))
      ],
    ));
  }
}

class MainScreen extends StatelessWidget {
  final String title;

  MainScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RUber'),
          centerTitle: false,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(children: [
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
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
                child: Text('Login (V2)'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
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

//    setState(() {
//      _messages.insert(0, message);
//    });
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

class NewRideScreen extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(title: Text('New Ride'), centerTitle: true),
        drawer: launchAppDrawer(context),
        body:
            DefaultTabController(length: 2, child: launchRideScreen(context)));
  }
}

class SettingsScreen extends StatelessWidget {
  Widget build(context) {
    return launchSettingsScreen(context);
  }
}
