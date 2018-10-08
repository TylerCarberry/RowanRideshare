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
          child: new FutureBuilder(
            future: fetchResponse(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(snapshot.data[index].name,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold)),
                            new Divider()
                          ]
                      );
                    }
                );
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future fetchResponse() async {

    List responseList;
    http.Response response = await http.get("http://10.0.2.2:8080/hello/greeting").catchError((resp) {});
    responseList = json.decode(response.body.toString());

    return responseList;


  }

}