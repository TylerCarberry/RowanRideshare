import 'package:flutter/material.dart';
import 'login.dart';
import 'RideScreen.dart';
import 'Rest.dart';
import 'AppDrawer.dart';
import 'settings_Screen.dart';
import 'MapPage.dart';
import 'package:map_view/map_view.dart';
import 'StaticMapPage.dart';

var api_key = "AIzaSyDrHKl8IxB4cGXIoELXQOzzZwiH1xtsRf4";



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
              Container(child: StaticMapPage(), height: 381.0),
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
