import 'package:flutter/material.dart';
import 'Rest.dart';
void main() {
  runApp(MaterialApp(
    title: 'RUber',
    home: MainScreen(),
  ));
}

class MainScreen extends StatelessWidget {
  final String title;
  MainScreen ({Key key, this.title}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RUber'),
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                      MaterialPageRoute(builder: (context) => Rest()),
                    );
                  }),
            ],
          ),
        ));
  }
}

class NewRideScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text('New Ride'), centerTitle: true),
      drawer: Drawer(
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
                  MaterialPageRoute(builder: (context) => MainScreen()),
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
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
            ),
          ],
        )
      ),
      body: DefaultTabController(
        length: 2,
        child: new Scaffold(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Rest()), // This grabs the data
                          );
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
        )
      )
    );
  }
}