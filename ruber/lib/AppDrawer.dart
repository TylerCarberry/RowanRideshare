import 'package:flutter/material.dart';

import 'RideScreen.dart';
import 'editschedule.dart';
import 'main.dart';
import 'profile.dart';
import 'ChatRoomScreen.dart';

Drawer launchAppDrawer(context) {
  return Drawer(
      child: ListView(
    children: <Widget>[
      DrawerHeader(
        child: Text('RUber Menu'),
        decoration: BoxDecoration(color: Colors.blue),
      ),
      ListTile(
        leading: Icon(Icons.arrow_back),
        title: Text('Main Menu'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        },
      ),
      ListTile(
          leading: Icon(Icons.directions_car),
          title: Text('New Ride'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => launchRideScreen()));
          }),
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
      ListTile(
        leading: Icon(Icons.schedule),
        title: Text('Schedule'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScheduleForm()));
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsScreen()),
          );
        },
      ),
    ],
  ));
}
