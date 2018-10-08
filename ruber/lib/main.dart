import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'RUber',
    home: MainScreen(),
  ));
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RUber'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text('New Ride'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewRideScreen()),
                  );
                },
              ),
              RaisedButton(
                  child: Text('Messages'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewRideScreen()),
                    );
                  }),
              RaisedButton(
                  child: Text('Profile'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewRideScreen()),
                    );
                  }),
              RaisedButton(
                  child: Text('Settings'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewRideScreen()),
                    );
                  }),
            ],
          ),
        ));
  }
}

class NewRideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}