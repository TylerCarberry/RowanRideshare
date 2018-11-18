// TODO: Work on the going to rowan and coming from rowan screens
// TODO: Finish the scheduling shit
// TODO: Make the user mandatorily enter the schedule and the edit address - might need new screen for edit schedule with just changing the submit button

import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Rest.dart';
import 'GoingToRowan.dart';

//class launchRideScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('New Ride'),
//          centerTitle: true,
//        ),
//        drawer: launchAppDrawer(context),
//        body: Row(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Expanded(
//              child: Container(
//                child: RaisedButton(
//                  child: Text('Coming from Rowan'),
//                  onPressed: () {
//                    print("Coming from Rowan");
//                  },
//                  color: Colors.yellow,
//                ),
//              ),
//            ),
//            Expanded(
//              child: Container(
//                child: RaisedButton(
//                  child: Text("Going to Rowan"),
//                  onPressed: () {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => goingtorowan()));
//                  },
//                  color: Colors.lightBlueAccent,
//                ),
//              ),
//            )
//          ],
//        ));
//  }
//}

class launchRideScreen extends StatefulWidget {
  @override
  _gtr createState() => new _gtr();
}

class _gtr extends State<launchRideScreen> {
  void _setRadius(double newValue) => setState(() => radius = newValue);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
