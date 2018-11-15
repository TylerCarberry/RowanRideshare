import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Rest.dart';

var scheduleMap = {
  "monday": "",
  "tuesday": "",
  "wednesday": "",
  "thursday": "",
  "friday": ""
};

getNewTime(String selectedTime) {
  String time = selectedTime;
  String newTime = "";
  String newTime2 = "";
  String newTime3 = "";
  int length = selectedTime.length;

  print("LENGTH OF SELECTED TIME: $length");
  print("TIME FROM PARAMETER: $time");


  if (time.substring(length - 1, length).startsWith('A')) {
    if (length == 7) {

      newTime = time.substring(0,1);

      print("NEW TIME 1 = $newTime");

      newTime2 = time.substring(2,4);

      print("NEW TIME 2 = $newTime2");


      newTime3 = newTime + newTime2;

      print("NEW TIME FROM FUNCTION: $newTime3");

      return newTime;
    }
    else {
      return "DOESN'T WORK";
    }
  }
}


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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
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
                                        '10:00 PM'
                                      ].map((String value) {
                                        return new DropdownMenuItem(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      // TODO: Need to figure out how to show the selection
                                      hint: new Text('6:00 AM'),
                                      onChanged: (value) {
                                        scheduleMap["monday"] = value;
                                        print(scheduleMap["monday"]);
                                        String blah = getNewTime(value);
                                        print("NEW TIME: $blah");
                                        setState(() {
                                          scheduleMap["monday"] = value;
                                        });
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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