/// editschedule.dart
///
/// Purpose:
/// The purpose of this file is to let the user edit their schedule
/// from the Main Screen. It does this by offering the user ranges
/// for each day - arriving and departing ranges. It shows the user
/// a menu of times to choose from.
/// There is A LOT of error checking involved inside this file
/// to prevent a user from entering incomplete schedule information
/// hence all the different vars

/// Imports
import 'dart:async';
import 'dart:async' show Future;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ruber/Constants.dart';
import 'package:ruber/Main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppDrawer.dart';
import 'ProfileModel.dart';
import 'ScheduleModel.dart';

/// This is the map that is to be sent to the database
/// If any of the 4 blocks are 0000 - that means that the user didn't
/// put in a time for that block and that entire day is invalid
var scheduleMap = {
  "monday": "",
  "tuesday": "",
  "wednesday": "",
  "thursday": "",
  "friday": ""
};

getId() async {
  int id;
  if (id == 0 || id == null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt("id");
  }
  ;
  return id;
}

/// Getter methods for the scheduleMap variable
getScheduleMapMonday() {
  return scheduleMap["monday"];
}

getScheduleMapTuesday() {
  return scheduleMap["tuesday"];
}

getScheduleMapWednesday() {
  return scheduleMap["wednesday"];
}

getScheduleMapThursday() {
  return scheduleMap["thursday"];
}

getScheduleMapFriday() {
  return scheduleMap["friday"];
}

getScheduleMap() {
  return scheduleMap;
}

/// Setter methods for the scheduleMap variable
setScheduleMapMonday(String a, String b, String c, String d) {
  scheduleMap["monday"] = a + b + c + d;
}

setScheduleMapTuesday(String a, String b, String c, String d) {
  scheduleMap["tuesday"] = a + b + c + d;
}

setScheduleMapWednesday(String a, String b, String c, String d) {
  scheduleMap["wednesday"] = a + b + c + d;
}

setScheduleMapThursday(String a, String b, String c, String d) {
  scheduleMap["thursday"] = a + b + c + d;
}

setScheduleMapFriday(String a, String b, String c, String d) {
  scheduleMap["friday"] = a + b + c + d;
}

/// The 'a' 'b' 'c' 'd' are the values for the hint text for the drop down
/// menus - they should be pulled from the database once there are values
/// in the database
/// as - arrival range start time
/// ae - arrival range end time
/// ls - leave range start time
/// le - leave range end time
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

var tuesdaySchedule = {
  "as": "",
  "ae": "",
  "ls": "",
  "le": "",
  "a": "0000",
  "b": "0000",
  "c": "0000",
  "d": "0000"
};

var wednesdaySchedule = {
  "as": "",
  "ae": "",
  "ls": "",
  "le": "",
  "a": "0000",
  "b": "0000",
  "c": "0000",
  "d": "0000"
};

var thursdaySchedule = {
  "as": "",
  "ae": "",
  "ls": "",
  "le": "",
  "a": "0000",
  "b": "0000",
  "c": "0000",
  "d": "0000"
};

var fridaySchedule = {
  "as": "",
  "ae": "",
  "ls": "",
  "le": "",
  "a": "0000",
  "b": "0000",
  "c": "0000",
  "d": "0000"
};

/// Changes the AM/PM time input from the user
/// to Military Time using string parsing.
String getNewTime(String selectedTime) {
  if (selectedTime.contains('AM', 0)) {
    /// AM times
    if (selectedTime.length == 7) {
      /// single digit AM times
      return ("0" +
          selectedTime.substring(0, 1) +
          selectedTime.substring(2, 4));
    } else {
      /// double digit AM times
      return (selectedTime.substring(0, 2) + selectedTime.substring(3, 5));
    }
  } else {
    /// PM times
    if (selectedTime.length == 7) {
      /// single digit PM times
      return ((int.parse(selectedTime.substring(0, 1)) + 12).toString() +
          selectedTime.substring(2, 4));
    } else {
      /// Double digit PM times - 12:00 PM and 12:30 PM
      return selectedTime.substring(0, 2) + selectedTime.substring(3, 5);
    }
  }
}

class ScheduleForm extends StatefulWidget {
  @override
  _MyScheduleForm createState() => _MyScheduleForm();
}

class _MyScheduleForm extends State<ScheduleForm> {
  bool a = true;
  bool b = true;
  bool c = true;
  bool d = true;
  bool e = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Schedule'),
          centerTitle: true,
        ),
        drawer: launchAppDrawer(context),
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

                    /// ======= MONDAY START========== //
                    /// ======= MONDAY START========== //

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
                              onChanged: (value) {
                                setState(() {
                                  mondaySchedule["as"] = value;
                                  mondaySchedule["a"] = getNewTime(value);

                                  setScheduleMapMonday(
                                      mondaySchedule["a"],
                                      mondaySchedule["b"],
                                      mondaySchedule["c"],
                                      mondaySchedule["d"]);
                                });

                                print("Mondays schedule " +
                                    getScheduleMapMonday());
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
                              onChanged: (value) {
                                setState(() {
                                  mondaySchedule["ae"] = value;
                                  mondaySchedule["b"] = getNewTime(value);
                                  setScheduleMapMonday(
                                      mondaySchedule["a"],
                                      mondaySchedule["b"],
                                      mondaySchedule["c"],
                                      mondaySchedule["d"]);
                                });

                                print("Mondays schedule " +
                                    getScheduleMapMonday());
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
                              onChanged: (value) {
                                setState(() {
                                  mondaySchedule["ls"] = value;
                                  mondaySchedule["c"] = getNewTime(value);
                                  setScheduleMapMonday(
                                      mondaySchedule["a"],
                                      mondaySchedule["b"],
                                      mondaySchedule["c"],
                                      mondaySchedule["d"]);
                                });

                                print("Mondays schedule " +
                                    getScheduleMapMonday());
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
                              onChanged: (value) {
                                setState(() {
                                  mondaySchedule["le"] = value;
                                  mondaySchedule["d"] = getNewTime(value);
                                  setScheduleMapMonday(
                                      mondaySchedule["a"],
                                      mondaySchedule["b"],
                                      mondaySchedule["c"],
                                      mondaySchedule["d"]);
                                });

                                print("Mondays schedule " +
                                    getScheduleMapMonday());

                                //create response

//
                              },
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  /// ======== MONDAY END ========= //


                  /// ======== TUESDAY START ========= //

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
                              onChanged: (value) {
                                setState(() {
                                  tuesdaySchedule["as"] = value;
                                  tuesdaySchedule["a"] = getNewTime(value);

                                  setScheduleMapTuesday(
                                      tuesdaySchedule["a"],
                                      tuesdaySchedule["b"],
                                      tuesdaySchedule["c"],
                                      tuesdaySchedule["d"]);
                                });

                                print("Tuesdays schedule " +
                                    getScheduleMapTuesday());
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
                              onChanged: (value) {
                                setState(() {
                                  tuesdaySchedule["ae"] = value;
                                  tuesdaySchedule["b"] = getNewTime(value);
                                  setScheduleMapTuesday(
                                      tuesdaySchedule["a"],
                                      tuesdaySchedule["b"],
                                      tuesdaySchedule["c"],
                                      tuesdaySchedule["d"]);
                                });

                                print("Tuesdays schedule " +
                                    getScheduleMapTuesday());
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
                              onChanged: (value) {
                                setState(() {
                                  tuesdaySchedule["ls"] = value;
                                  tuesdaySchedule["c"] = getNewTime(value);
                                  setScheduleMapTuesday(
                                      tuesdaySchedule["a"],
                                      tuesdaySchedule["b"],
                                      tuesdaySchedule["c"],
                                      tuesdaySchedule["d"]);
                                });

                                print("Tuesdays schedule " +
                                    getScheduleMapTuesday());
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
                              onChanged: (value) {
                                setState(() {
                                  tuesdaySchedule["le"] = value;
                                  tuesdaySchedule["d"] = getNewTime(value);
                                  setScheduleMapTuesday(
                                      tuesdaySchedule["a"],
                                      tuesdaySchedule["b"],
                                      tuesdaySchedule["c"],
                                      tuesdaySchedule["d"]);
                                });

                                print("Tuesdays schedule " +
                                    getScheduleMapTuesday());
                              },
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  /// ======== TUESDAY END ========= //


                  /// ======== WEDNESDAY START ========= //

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
                              onChanged: (value) {
                                setState(() {
                                  wednesdaySchedule["as"] = value;
                                  wednesdaySchedule["a"] = getNewTime(value);

                                  setScheduleMapWednesday(
                                      wednesdaySchedule["a"],
                                      wednesdaySchedule["b"],
                                      wednesdaySchedule["c"],
                                      wednesdaySchedule["d"]);
                                });

                                print("Wednesdays schedule " +
                                    getScheduleMapWednesday());
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
                              onChanged: (value) {
                                setState(() {
                                  wednesdaySchedule["ae"] = value;
                                  wednesdaySchedule["b"] = getNewTime(value);
                                  setScheduleMapWednesday(
                                      wednesdaySchedule["a"],
                                      wednesdaySchedule["b"],
                                      wednesdaySchedule["c"],
                                      wednesdaySchedule["d"]);
                                });

                                print("Wednesdays schedule " +
                                    getScheduleMapWednesday());
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
                              onChanged: (value) {
                                setState(() {
                                  wednesdaySchedule["ls"] = value;
                                  wednesdaySchedule["c"] = getNewTime(value);
                                  setScheduleMapWednesday(
                                      wednesdaySchedule["a"],
                                      wednesdaySchedule["b"],
                                      wednesdaySchedule["c"],
                                      wednesdaySchedule["d"]);
                                });

                                print("Wednesdays schedule " +
                                    getScheduleMapWednesday());
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
                              onChanged: (value) {
                                setState(() {
                                  wednesdaySchedule["le"] = value;
                                  wednesdaySchedule["d"] = getNewTime(value);
                                  setScheduleMapWednesday(
                                      wednesdaySchedule["a"],
                                      wednesdaySchedule["b"],
                                      wednesdaySchedule["c"],
                                      wednesdaySchedule["d"]);
                                });

                                print("Wednesdays schedule " +
                                    getScheduleMapWednesday());
                              },
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  /// ======== WEDNESDAY END ========= //



                  /// ======== THURSDAY START ========= //

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
                              onChanged: (value) {
                                setState(() {
                                  thursdaySchedule["as"] = value;
                                  thursdaySchedule["a"] = getNewTime(value);

                                  setScheduleMapThursday(
                                      thursdaySchedule["a"],
                                      thursdaySchedule["b"],
                                      thursdaySchedule["c"],
                                      thursdaySchedule["d"]);
                                });

                                print("Thursdays schedule: " +
                                    getScheduleMapThursday());
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
                              onChanged: (value) {
                                setState(() {
                                  thursdaySchedule["ae"] = value;
                                  thursdaySchedule["b"] = getNewTime(value);
                                  setScheduleMapThursday(
                                      thursdaySchedule["a"],
                                      thursdaySchedule["b"],
                                      thursdaySchedule["c"],
                                      thursdaySchedule["d"]);
                                });

                                print("Thursdays schedule: " +
                                    getScheduleMapThursday());
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
                              onChanged: (value) {
                                setState(() {
                                  thursdaySchedule["ls"] = value;
                                  thursdaySchedule["c"] = getNewTime(value);
                                  setScheduleMapThursday(
                                      thursdaySchedule["a"],
                                      thursdaySchedule["b"],
                                      thursdaySchedule["c"],
                                      thursdaySchedule["d"]);
                                });

                                print("Thursdays schedule: " +
                                    getScheduleMapThursday());
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
                              onChanged: (value) {
                                setState(() {
                                  thursdaySchedule["le"] = value;
                                  thursdaySchedule["d"] = getNewTime(value);
                                  setScheduleMapThursday(
                                      thursdaySchedule["a"],
                                      thursdaySchedule["b"],
                                      thursdaySchedule["c"],
                                      thursdaySchedule["d"]);
                                });

                                print("Thursdays schedule: " +
                                    getScheduleMapThursday());
                              },
                            ),
                          ],
                        )
                      ],
                    ))
                  ]),

                  /// ======== THURSDAY END ========= //


                  /// ======== FRIDAY START ========= //

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
                              onChanged: (value) {
                                setState(() {
                                  fridaySchedule["as"] = value;
                                  fridaySchedule["a"] = getNewTime(value);

                                  setScheduleMapFriday(
                                      fridaySchedule["a"],
                                      fridaySchedule["b"],
                                      fridaySchedule["c"],
                                      fridaySchedule["d"]);
                                });

                                print("Fridays schedule: " +
                                    getScheduleMapFriday());
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
                              onChanged: (value) {
                                setState(() {
                                  fridaySchedule["ae"] = value;
                                  fridaySchedule["b"] = getNewTime(value);
                                  setScheduleMapFriday(
                                      fridaySchedule["a"],
                                      fridaySchedule["b"],
                                      fridaySchedule["c"],
                                      fridaySchedule["d"]);
                                });

                                print("Fridays schedule: " +
                                    getScheduleMapFriday());
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
                              onChanged: (value) {
                                setState(() {
                                  fridaySchedule["ls"] = value;
                                  fridaySchedule["c"] = getNewTime(value);
                                  setScheduleMapFriday(
                                      fridaySchedule["a"],
                                      fridaySchedule["b"],
                                      fridaySchedule["c"],
                                      fridaySchedule["d"]);
                                });

                                print("Fridays schedule: " +
                                    getScheduleMapFriday());
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
                              onChanged: (value) {
                                setState(() {
                                  fridaySchedule["le"] = value;
                                  fridaySchedule["d"] = getNewTime(value);
                                  setScheduleMapFriday(
                                      fridaySchedule["a"],
                                      fridaySchedule["b"],
                                      fridaySchedule["c"],
                                      fridaySchedule["d"]);
                                });

                                print("Fridays schedule: " +
                                    getScheduleMapFriday());
                              },
                            ),
                          ],
                        )
                      ],
                    ))
                  ])

                  /// ================== FRIDAY END ==================== //
                  /// ================== FRIDAY END ==================== //


                  /// The submit button does the error checking and then
                  /// saves the new schedule to the data base
                  /// If the military time string - contains a set of 4 0's
                  /// then, we know that one of the range inputs for a day
                  /// was incomplete, and we don't allow the user to press
                  /// the submit button until they have entered a valid time

                ]),
            RaisedButton(
                child: Text("Submit"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  if (getScheduleMapMonday().toString().contains("0000", 0) ||
                      getScheduleMapMonday() == "") {
                    a = false;
                  } else {
                    Schedule updateMonday = new Schedule(
                      monday: getScheduleMapMonday(),
                    );
                    newSchedule(updateMonday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });

                    updateSchedule(updateMonday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });
                    a = true;
                  }

                  if (getScheduleMapTuesday().toString().contains("0000", 0) ||
                      getScheduleMapTuesday() == "") {
                    b = false;
                  } else {
                    Schedule updateTuesday = new Schedule(
                      tuesday: getScheduleMapTuesday(),
                    );

                    newSchedule(updateTuesday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });

                    updateSchedule(updateTuesday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });
                    b = true;
                  }

                  if (getScheduleMapWednesday()
                          .toString()
                          .contains("0000", 0) ||
                      getScheduleMapWednesday() == "") {
                    c = false;
                  } else {
                    Schedule updateWednesday = new Schedule(
                      wednesday: getScheduleMapWednesday(),
                    );

                    newSchedule(updateWednesday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });

                    updateSchedule(updateWednesday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });
                    c = true;
                  }

                  if (getScheduleMapThursday().toString().contains("0000", 0) ||
                      getScheduleMapThursday() == "") {
                    d = false;
                  } else {
                    Schedule updateThursday = new Schedule(
                      thursday: getScheduleMapThursday(),
                    );

                    newSchedule(updateThursday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });

                    updateSchedule(updateThursday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });
                    d = true;
                  }

                  if (getScheduleMapFriday().toString().contains("0000", 0) ||
                      getScheduleMapFriday() == "") {
                    e = false;
                  } else {
                    Schedule updateFriday = new Schedule(
                      friday: getScheduleMapFriday(),
                    );

                    newSchedule(updateFriday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });

                    updateSchedule(updateFriday).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });
                    e = true;
                  }

                  if ((a || b || c || d || e) == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MainScreen())
                        );
                  } else {
                    return null;
                  }
                })
          ],
        )));
  }
}
/*
* This method return the users information so that is can be checked during edit.
 */
Future<Post> getPost() async {
  int userId = await getId();
  String postUrl = BASE_URL + '/rides/profile/$userId';
  final response = await http.get(postUrl);
  return postFromJson(response.body);
}
/*
*This method allows the user to changes the times for days in their schedule.
 */
Future<http.Response> updateSchedule(Schedule schedule) async {
  int userId = await getId();
  String updateUrl = BASE_URL + '/rides/profile/$userId/schedule/update';
  final response = await http.post('$updateUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: scheduleToJson(schedule));
  return response;
}

/*
*This method is used to add new days to the users schedule during an edit.
 */
Future<http.Response> newSchedule(Schedule newSchedule) async {
  int userId = await getId();
  String updateUrl = BASE_URL + '/rides/profile/$userId/schedule/new';
  final response = await http.post('$updateUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: scheduleToJson(newSchedule));
  return response;
}
