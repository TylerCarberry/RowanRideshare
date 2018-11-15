import 'package:flutter/material.dart';
import 'Rest.dart';

Scaffold launchRideScreen(context) {
  return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        title: TabBar(
          tabs: <Widget>[Tab(icon: Icon(Icons.directions_car), text: 'Going to Rowan'),
          Tab(icon: Icon(Icons.directions_run), text: 'Going Home')
          ],
          indicatorColor: Colors.white,
        ),
        automaticallyImplyLeading: false,
      ),
      body: TabBarView(
        children: <Widget>[
//              Icon(Icons.directions_car, size: 50.0),
//              Icon(Icons.directions_run, size: 50.0),
          Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Starting Address: '
                      )
                  ),
                  RaisedButton(
                    child: Text('Go!'),
                    onPressed: ()
                    {


                    },
                  )
                ],
              )
          ),
          Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Destination Address: '
                      )
                  ),
                  RaisedButton(
                    child: Text('Go!'),
                    onPressed: ()
                    {

                    },
                  )
                ],
              )
          )
        ],
      )
  );
}