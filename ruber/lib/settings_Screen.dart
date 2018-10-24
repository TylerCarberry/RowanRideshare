import 'package:flutter/material.dart';
import 'AppDrawer.dart';

Scaffold launchSettingsScreen(context) {
  return Scaffold(
    appBar: AppBar(title: Text('Settings'), centerTitle: true),
    drawer: launchAppDrawer(context),
    body: new Center(
      child: Column(
        children: [
          RaisedButton(
            child: Text('Sign Out'),
            onPressed: () {
              SignOut();
            },
          ),
          RaisedButton(
            child: Text('Edit Schedule'),
            onPressed: () {
              EditSchedule(); //Note that this will evenutally have to be a screen instead of just a function call
            },
          ),
          RaisedButton(
            child: Text('Edit Home Address'),
            onPressed: () {
              EditHomeAddress();
            },
          ),
          RaisedButton(
            child: Text('Edit Name'),
            onPressed: () {
              EditName();
            }
          )
        ]
      )
    )
  );
}

SignOut() {
  print("You've Signed Out!!!");
}

EditSchedule() {
  print("You've Edited your Schedule!!!");
}

EditHomeAddress() {
  print("You've Editied your Home Address!!!");
}

EditName() {
  print("You've Editied you Name!!!");
}