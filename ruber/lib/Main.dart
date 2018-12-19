/// Main.dart
///
/// Purpose:
/// The purpose of this file is to act as the main starting point
/// of the app. It describes the Welcome screen which goes
/// to the Google OAuth screen. This also includes the main
/// menu screen which is the starting point of the app once the user
/// is created.


/// Imports
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'AppDrawer.dart';
import 'AuthScreen.dart';
import 'ChatRoomScreen.dart';
import 'RideScreen.dart';
import 'editschedule.dart';
import 'profile.dart';

var api_key = "AIzaSyDrHKl8IxB4cGXIoELXQOzzZwiH1xtsRf4";

void main() => runApp(new RUber());

class RUber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ryde',
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen());
  }
}

/// ==================== WELCOME SCREEN ====================== //

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Ryde'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'Ryde',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 80.0,
                      fontFamily: "Audiowide"),
                ),
              ),
              Image.network(
                'https://www.tlcrentalmarketplace.com/wp-content/uploads/2018/03/rideshare.png',
                height: 150,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 40.0, left: 15.0, right: 15.0, bottom: 15.0),
                child: Text(
                  'Exclusively for Rowan University students\n\n Commute with other students near you\n\n Match based on class schedule and distance\n\n Save gas and the planet!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontFamily: "",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                child: Text(
                  "Start",
                  style: TextStyle(fontSize: 20),
                ),
                textColor: Colors.white,
                color: Colors.blue,
                minWidth: 100.0,
                height: 70.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyAuthScreen()));
                },
              ),
            ],
          ),
        ));
  }
}

/// =========================== END WELCOME SCREEN ====================== //

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final String title;

  MainScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Ryde',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Audiowide",
                      color: Colors.white)),
              centerTitle: true,
              leading: IconButton(
                  icon: new Image.network(
                      'https://www.tlcrentalmarketplace.com/wp-content/uploads/2018/03/rideshare.png'),
                  onPressed: () => _scaffoldKey.currentState.openDrawer()),
            ),
            drawer: launchAppDrawer(context),
            key: _scaffoldKey,
            body: Center(
              child: Column(children: [
                Image.network(
                  'https://www.tlcrentalmarketplace.com/wp-content/uploads/2018/03/rideshare.png',
                  height: 150,
                ),
                ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text('New Ryde'),
                    contentPadding: new EdgeInsets.only(left: 100.0, top: 30.0),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => launchRideScreen()));
                    }),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Messages'),
                  contentPadding: new EdgeInsets.only(left: 100.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatRoomScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text('Profile'),
                  contentPadding: new EdgeInsets.only(left: 100.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.schedule),
                  title: Text('Schedule'),
                  contentPadding: new EdgeInsets.only(left: 100.0),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleForm()));
                  },
                )
              ]),
            )));
  }
}
