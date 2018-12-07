import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppDrawer.dart';
import 'GoingToRowan.dart';
import 'matches_screen.dart';

class launchRideScreen extends StatefulWidget {
  @override
  _gtr createState() => new _gtr();
}

saveRadius(double radius) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("radius", radius.toInt());
}

class _gtr extends State<launchRideScreen> {
  void _setRadius(double newValue) => setState(() => radius = newValue);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("New Ride"),
          centerTitle: true,
        ),
        drawer: launchAppDrawer(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Select the radius for searching',
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold)),
            Text(
              'Radius: ${radius.toInt()} miles',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: radius,
              min: 0,
              max: 20,
              onChanged: _setRadius,
            ),
            RaisedButton(
              child: Text('Find Rides!'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                saveRadius(radius);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => matchesScreen()));
              },
            )
          ],
        ));
  }
}
