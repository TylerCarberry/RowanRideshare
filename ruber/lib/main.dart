import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('RUber'), centerTitle: true,
            ),
            body: Center(
                child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.all(10.0),
                          child: RaisedButton(
                              child: Text('New Ride'),
                              onPressed: () {

                              }
                          )
                      ),
                      Container(
                          margin: EdgeInsets.all(10.0),
                          child: RaisedButton(
                            child: Text('Messages'),
                            onPressed: () {

                            },
                          )
                      ),
                      Container(
                          margin: EdgeInsets.all(10.0),
                          child: RaisedButton(
                            child: Text("Profile"),
                            onPressed: () {

                            },
                          )
                      ),
                      Container(
                          margin: EdgeInsets.all(10.0),
                          child: RaisedButton(
                            child: Text("Settings"),
                            onPressed: () {

                            },
                          )
                      )
                    ]
                )
            ))
    );
  }
}

//class NewRideScreen extends StatelessWidget
//{
//  @override
//  Widget build(BuildContext context)
//  {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("New Ride")
//      ),
//      body: Center(
//        child: Column
//      )
//    );
//  }
//}