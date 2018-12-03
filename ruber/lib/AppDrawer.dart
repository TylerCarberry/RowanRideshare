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
        child: Image.network(
          'https://www.tlcrentalmarketplace.com/wp-content/uploads/2018/03/rideshare.png',
          height: 150,
        ),
      ),
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
    ],
  ));
}
