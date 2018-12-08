import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppDrawer.dart';

double radius = 0;

getRadius() {
  return radius.toInt();
}

class goingtorowan extends StatefulWidget {
  @override
  _gtr createState() => new _gtr();
}

setRadius(int radius) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("radius", radius);
}

class _gtr extends State<goingtorowan> {
  void _setRadius(double newValue) => setState(() => radius = newValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Going to Rowan"),
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
              onPressed: () {
                print("Hello");
              },
            )
          ],
        ));
  }
}
