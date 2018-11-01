import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'User.dart';

class Rest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          //body of the scaffold is a container with a http pull
          child: Center(
            child: FutureBuilder(
              future: loadUser(),
              builder: (context, snapshot) {
                //print(snapshot.data.title);
                //print (snapshot.connectionState.toString());
                if (snapshot.hasData) {
                  //return Text('${snapshot.data}');
                  print(snapshot.data.toString());
                  return Text(snapshot.data.toString());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.data.toString()}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future fetchResponse() async {
    String responseList;
    http.Response response = await http
        .get("http://10.0.2.2:8080/hello/greeting")
        .catchError((resp) {});
    responseList = response.body.toString();

    return responseList;
  }

  Future<String> _loadUserAsset() async {
    return await rootBundle.loadString('assets/User_Structure.json');
  }

  Future loadUser() async {
    String jsonString = await _loadUserAsset();
    final jsonResponse = json.decode(jsonString);
    User user = new User.fromJson(jsonResponse);
    print(user.userName);

    return user.userName;
  }
}
