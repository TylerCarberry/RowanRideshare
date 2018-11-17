import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Rest.dart';

class launchRideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('New Ride'),
          centerTitle: true,
        ),
        drawer: launchAppDrawer(context),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                child: RaisedButton(
                  child: Text('Coming from Rowan'),
                  onPressed: () {
                    print("Coming from Rowan");
                  },
                  color: Colors.yellow,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: RaisedButton(
                  child: Text("Going to Rowan"),
                  onPressed: () {
                    print("Going to Rowan");
                  },
                  color: Colors.lightBlueAccent,
                ),
              ),
            )
          ],
        ));
  }
}
