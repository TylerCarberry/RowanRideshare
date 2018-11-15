import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Rest.dart';

// TODO: Get the value from the drop down menu and make that into a map - to send it to the back end

class ScheduleForm extends StatefulWidget {
  @override
  _MyScheduleForm createState() => _MyScheduleForm();
}

class _MyScheduleForm extends State<ScheduleForm> {
  final monCont = TextEditingController();
  final tuesCont = TextEditingController();
  final wedCont = TextEditingController();
  final thursCont = TextEditingController();
  final friCont = TextEditingController();

  @override
  void dispose() {
    monCont.dispose();
    tuesCont.dispose();
    wedCont.dispose();
    thursCont.dispose();
    friCont.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Schedule'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(30.0),
              child: Text(
                "Click on the drop down menu to enter your schedule",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 15.0),
              ),
            ),
            Table(
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: [
                  TableRow(children: [
                    // MONDAY

                    TableCell(
                        child: Column(
                      children: <Widget>[
                        Text(
                          'Monday',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 20.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Text('Arrive between'),
                            ),
                            Container(child: Text('Leave between'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text("6:00 AM"),
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            Text('   ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  // TUESDAY

                  TableRow(children: [
                    TableCell(
                        child: Column(
                      children: <Widget>[
                        Text(
                          'Tuesday',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                              fontSize: 20.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Text('Arrive between'),
                            ),
                            Container(child: Text('Leave between'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text("6:00 AM"),
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            Text('   ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  // WEDNESDAY

                  TableRow(children: [
                    TableCell(
                        child: Column(
                      children: <Widget>[
                        Text(
                          'Wednesday',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 20.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Text('Arrive between'),
                            ),
                            Container(child: Text('Leave between'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text("6:00 AM"),
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            Text('   ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  // THURSDAY

                  TableRow(children: [
                    TableCell(
                        child: Column(
                      children: <Widget>[
                        Text(
                          'Thursday',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 20.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Text('Arrive between'),
                            ),
                            Container(child: Text('Leave between'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text("6:00 AM"),
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            Text('   ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  // FRIDAY

                  TableRow(children: [
                    TableCell(
                        child: Column(
                      children: <Widget>[
                        Text(
                          'Friday',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                              fontSize: 20.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Text('Arrive between'),
                            ),
                            Container(child: Text('Leave between'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text("6:00 AM"),
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            Text('   ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                            DropdownButton<String>(
                              items: <String>['6:00 AM', '6:30 AM']
                                  .map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text('6:00 AM'),
                              onChanged: (_) {},
                            ),
                          ],
                        )
                      ],
                    ))
                  ])
                ]),
          ],
        )));
  }
}
