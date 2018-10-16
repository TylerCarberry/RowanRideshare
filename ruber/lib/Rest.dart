import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Rest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Container( //body of the scaffold is a container with a http pull
          child: Center(
          child: FutureBuilder(
            future: fetchResponse(),

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
    http.Response response = await http.get("http://10.0.2.2:8080/hello/greeting").catchError((resp) {});
    responseList = response.body.toString();

    return responseList;


  }

}