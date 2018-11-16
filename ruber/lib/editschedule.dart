// TODO: Get the value from the drop down menu and make that into a map - to send it to the back end
// TODO: The individial day schedules should pull directly from the database
// TODO: The schedule has to be inputted in a certain pattern or else it will fuck up -- Need to clear the schedulemap everytime you finish the screen


import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'package:ruber/Main.dart';
import 'Rest.dart';

var scheduleMap = {
  "monday": "",
  "tuesday": "",
  "wednesday": "",
  "thursday": "",
  "friday": ""
};

var mondaySchedule = {
  "as": "",
  "ae": "",
  "ls": "",
  "le": "",
  "a": "0000",
  "b": "0000",
  "c": "0000",
  "d": "0000"
};

String getNewTime(String selectedTime) {
  if (selectedTime.contains('AM', 0)) {
    // AM times
    if (selectedTime.length == 7) {
      // single digit AM times
      print("0" + selectedTime.substring(0, 1) + selectedTime.substring(2, 4));
      return ("0" +
          selectedTime.substring(0, 1) +
          selectedTime.substring(2, 4));
    } else {
      // double digit AM times
      print(selectedTime.substring(0, 2) + selectedTime.substring(3, 5));
      return (selectedTime.substring(0, 2) + selectedTime.substring(3, 5));
    }
  } else {
    // PM times
    if (selectedTime.length == 7) {
      // single digit PM times
      print("0" + selectedTime.substring(0, 1) + selectedTime.substring(2, 4));
      return ((int.parse(selectedTime.substring(0, 1)) + 12).toString() +
          selectedTime.substring(2, 4));
    } else {
      // Double digit PM times - 12:00 PM and 12:30 PM
      print(selectedTime.substring(0, 2) + selectedTime.substring(3, 5));
      return selectedTime.substring(0, 2) + selectedTime.substring(3, 5);
    }
  }
}

class ScheduleForm extends StatefulWidget {
  @override
  _MyScheduleForm createState() => _MyScheduleForm();
}

class _MyScheduleForm extends State<ScheduleForm> {
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

                    // ======= MONDAY START========== //
                    // ======= MONDAY START========== //
                    // ======= MONDAY START========== //
                    // ======= MONDAY START========== //

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
                              items: <String>[
                                '7:00 AM',
                                '7:30 AM',
                                '8:00 AM',
                                '8:30 AM',
                                '9:00 AM',
                                '9:30 AM',
                                '10:00 AM',
                                '10:30 AM',
                                '11:00 AM',
                                '11:30 AM',
                                '12:00 PM',
                                '12:30 PM',
                                '1:00 PM',
                                '1:30 PM',
                                '2:00 PM',
                                '2:30 PM',
                                '3:00 PM',
                                '3:30 PM',
                                '4:00 PM',
                                '4:30 PM',
                                '5:00 PM',
                                '5:30 PM',
                                '6:00 PM',
                                '6:30 PM',
                                '7:00 PM',
                                '7:30 PM',
                                '8:00 PM',
                                '8:30 PM',
                                '9:00 PM',
                                '9:30 PM',
                              ].map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              // TODO: Need to figure out how to show the selection
                              hint: new Text(mondaySchedule["as"]),
                              onChanged: (value) {
                                setState(() {
                                  mondaySchedule["as"] = value;
                                  mondaySchedule["a"] = getNewTime(value);
                                  scheduleMap["monday"] = mondaySchedule["a"] +
                                      mondaySchedule["b"] +
                                      mondaySchedule["c"] +
                                      mondaySchedule["d"];
                                });

                                print(scheduleMap["monday"]);
                              },
                            ),
                            DropdownButton<String>(
                              items: <String>[
                                '7:00 AM',
                                '7:30 AM',
                                '8:00 AM',
                                '8:30 AM',
                                '9:00 AM',
                                '9:30 AM',
                                '10:00 AM',
                                '10:30 AM',
                                '11:00 AM',
                                '11:30 AM',
                                '12:00 PM',
                                '12:30 PM',
                                '1:00 PM',
                                '1:30 PM',
                                '2:00 PM',
                                '2:30 PM',
                                '3:00 PM',
                                '3:30 PM',
                                '4:00 PM',
                                '4:30 PM',
                                '5:00 PM',
                                '5:30 PM',
                                '6:00 PM',
                                '6:30 PM',
                                '7:00 PM',
                                '7:30 PM',
                                '8:00 PM',
                                '8:30 PM',
                                '9:00 PM',
                                '9:30 PM',
                              ].map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text(mondaySchedule["ae"]),
                              onChanged: (value) {
                                setState(() {
                                  mondaySchedule["ae"] = value;
                                  mondaySchedule["b"] = getNewTime(value);
                                  scheduleMap["monday"] = mondaySchedule["a"] +
                                      mondaySchedule["b"] +
                                      mondaySchedule["c"] +
                                      mondaySchedule["d"];
                                });

                                print(scheduleMap["monday"]);
                              },
                            ),
                            Text('   ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            DropdownButton<String>(
                              items: <String>[
                                '7:00 AM',
                                '7:30 AM',
                                '8:00 AM',
                                '8:30 AM',
                                '9:00 AM',
                                '9:30 AM',
                                '10:00 AM',
                                '10:30 AM',
                                '11:00 AM',
                                '11:30 AM',
                                '12:00 PM',
                                '12:30 PM',
                                '1:00 PM',
                                '1:30 PM',
                                '2:00 PM',
                                '2:30 PM',
                                '3:00 PM',
                                '3:30 PM',
                                '4:00 PM',
                                '4:30 PM',
                                '5:00 PM',
                                '5:30 PM',
                                '6:00 PM',
                                '6:30 PM',
                                '7:00 PM',
                                '7:30 PM',
                                '8:00 PM',
                                '8:30 PM',
                                '9:00 PM',
                                '9:30 PM',
                              ].map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text(mondaySchedule["ls"]),
                              onChanged: (value) {
                                setState(() {
                                  mondaySchedule["ls"] = value;
                                  mondaySchedule["c"] = getNewTime(value);
                                  scheduleMap["monday"] = mondaySchedule["a"] +
                                      mondaySchedule["b"] +
                                      mondaySchedule["c"] +
                                      mondaySchedule["d"];
                                });

                                print(scheduleMap["monday"]);
                              },
                            ),
                            DropdownButton<String>(
                              items: <String>[
                                '7:00 AM',
                                '7:30 AM',
                                '8:00 AM',
                                '8:30 AM',
                                '9:00 AM',
                                '9:30 AM',
                                '10:00 AM',
                                '10:30 AM',
                                '11:00 AM',
                                '11:30 AM',
                                '12:00 PM',
                                '12:30 PM',
                                '1:00 PM',
                                '1:30 PM',
                                '2:00 PM',
                                '2:30 PM',
                                '3:00 PM',
                                '3:30 PM',
                                '4:00 PM',
                                '4:30 PM',
                                '5:00 PM',
                                '5:30 PM',
                                '6:00 PM',
                                '6:30 PM',
                                '7:00 PM',
                                '7:30 PM',
                                '8:00 PM',
                                '8:30 PM',
                                '9:00 PM',
                                '9:30 PM',
                              ].map((String value) {
                                return new DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              hint: Text(mondaySchedule["le"]),
                              onChanged: (value) {
                                setState(() {
                                  mondaySchedule["le"] = value;
                                  mondaySchedule["d"] = getNewTime(value);
                                  scheduleMap["monday"] = mondaySchedule["a"] +
                                      mondaySchedule["b"] +
                                      mondaySchedule["c"] +
                                      mondaySchedule["d"];
                                });

                                print(scheduleMap["monday"]);
                              },
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  // ======== MONDAY END ========= //
                  // ======== MONDAY END ========= //
                  // ======== MONDAY END ========= //
                  // ======== MONDAY END ========= //


                  // ======== TUESDAY START ========= //

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
                              items: <String>[
                                '7:00 AM',
                                '7:30 AM',
                                '8:00 AM',
                                '8:30 AM',
                                '9:00 AM',
                                '9:30 AM',
                                '10:00 AM',
                                '10:30 AM'
                              ].map((String value) {
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
            RaisedButton(
              child: Text("Submit"),
              onPressed: () {
                //Change this to AuthScreen()
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MainScreen()) //Change this to AuthScreen()
                    );
              },
            )
          ],
        )));
  }
}
