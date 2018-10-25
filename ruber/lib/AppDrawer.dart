import 'package:flutter/material.dart';
import 'main.dart';

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
                MaterialPageRoute(builder: (context) => MessagesScreen()),
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
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      )
  );
}