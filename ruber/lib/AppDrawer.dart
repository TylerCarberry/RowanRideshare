/// AppDrawer.dart
///
/// Purpose:
/// This file is used for the app drawer in flutter
/// It shows a menu whenever the user clicks on the app drawer icon
/// on the top left hand side of the app.

/// Imports
import 'package:flutter/material.dart';

import 'ChatRoomScreen.dart';
import 'RideScreen.dart';
import 'editschedule.dart';
import 'main.dart';
import 'profile.dart';

/// Drawer Widget which holds all the drawer options
/// Drawer Options:
/// 1) Main Screen - MainScreen()
/// 2) New Ryde Screen - launchRideScreen()
/// 3) Messages Screen - ChatRoomScreen()
/// 4) Profile Screen - ProfileScreen()
/// 5) Schedule Screen - ScheduleForm()
Drawer launchAppDrawer(context) {
  return Drawer(
      child: ListView(
    children: <Widget>[
      DrawerHeader(
        child: Image.network(
          'https://www.tlcrentalmarketplace.com/wp-content/uploads/2018/03/rideshare.png',
          height: 150,
        ),
      ),

      /// Main Screen option

      ListTile(
        leading: Icon(Icons.home),
        title: Text('Main Menu'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        },
      ),

      /// New Ryde screen option

      ListTile(
          leading: Icon(Icons.directions_car),
          title: Text('New Ride'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => launchRideScreen()));
          }),

      /// Messages screen option

      ListTile(
        leading: Icon(Icons.message),
        title: Text('Messages'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoomScreen()),
          );
        },
      ),

      /// Profile screen option

      ListTile(
        leading: Icon(Icons.account_box),
        title: Text('Profile'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        },
      ),

      /// Schedule screen option

      ListTile(
        leading: Icon(Icons.schedule),
        title: Text('Schedule'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScheduleForm()));
        },
      ),
    ],
  ));
}
