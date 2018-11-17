import 'package:flutter/material.dart';
import 'Rest.dart';

Scaffold launchRideScreen(context) {
  var textController = new TextEditingController();

  return new Scaffold(
      appBar: AppBar(
        title: Text('Ride Screen'),
      ),
      body: new Row(
        children: <Widget> [
          new Column(
              children: [
                RaisedButton(
                  child: Text('Ride to Rowan')
                )
              ]

          ),
          new Column(
            children: [
              RaisedButton(
                child: Text('Get a Ride Home')
              )
            ]
          ),
      ],
    ),
  );
}