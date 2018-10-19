import 'package:flutter/material.dart';
import 'Rest.dart';
import 'login.dart';
import 'RideScreen.dart';


void main() {
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
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
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
                      MaterialPageRoute(builder: (context) => NewRideScreen()),
                    );
                  }),
              RaisedButton(
                  child: Text('Profile'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewRideScreen()),
                    );
                  }),
              RaisedButton(
                  child: Text('Settings'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewRideScreen()),
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
            ],
          ),
        ));
  }
}

class TextForm extends StatefulWidget {
  _TextForm createState() => _TextForm();
}

class _TextForm extends State<TextForm> {
  final myController  = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController1 = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: new Column(
            children: <Widget>[
              new ListTile(
                leading: const Icon(Icons.person),
                title: new TextField(
                  controller: myController,
                  decoration: new InputDecoration(
                    hintText: "First Name",
                  ),
                  maxLength: 45,
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.person_outline),
                title: new TextField(
                  controller: myController1,
                  decoration: new InputDecoration(
                    hintText: "Last Name",
                  ),
                  maxLength: 45,
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.email),
                title: new TextField(
                  controller: myController2,
                  decoration: new InputDecoration(
                    hintText: "Email",
                  ),
                  maxLength: 50,
                ),
              ),
              new ListTile(
                leading: const Icon(Icons.location_city),
                title: new TextField(
                  controller: myController3,
                  decoration: new InputDecoration(
                    hintText: "Location",
                  ),
                  maxLength: 50,
                ),
              ),
            ]
        ) ,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(myController.text + " " + myController1.text + " " + myController2.text + " " + myController3.text),
                );
              },
            );
          },
          tooltip: 'Show me the value!',
          child: Icon(Icons.text_fields),
        ),
      );
    }
}

//class MessagesScreen extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context)
//  {
//    return Scaffold(
//      appBar: AppBar(title: Text('New Ride'), centerTitle: true),
//        child: Container(
//          margin: const EdgeInsets.all(10.0),
//          color: const Color(0xFF00FF00),
//          width: 48.0,
//          height: 48.0,
//        ),
//    );
//  }
//
//}

class NewRideScreen extends StatelessWidget {

  @override
  Widget build(context)
  {
      return Scaffold(
          appBar: AppBar(title: Text('New Ride'), centerTitle: true),
          drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Text('RUber Menu'),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_back),
                    title: Text('Main Menu'),
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Messages'),
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.account_box),
                    title: Text('Profile'),
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                  ),
                ],
              )
          ),
          body: DefaultTabController(
              length: 2,
              child: launchRideScreen(context) //Launches method in RideScreen.dart file
          )
      );
  }
}