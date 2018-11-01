import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'PostModel.dart';
import 'dart:io';

class Rest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          //body of the scaffold is a container with a http pull
          child: Center(
              child: FutureBuilder<Post>(
                  future: getPost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Text(
                          'Created Date from Post JSON : ${snapshot.data.createdDate}');
                    else
                      return CircularProgressIndicator();
                  })),
        ),
      ),
    );
  }

  String url = 'http://10.0.2.2:8080/rides/profile/1';

  Future<List<Post>> getAllPosts() async {
    final response = await http.get(url);
    print(response.body);
    return allPostsFromJson(response.body);
  }

  Future<Post> getPost() async {
    final response = await http.get(url);
    return postFromJson(response.body);
  }

  Future<http.Response> createPost(Post post) async {
    final response = await http.post('$url',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: ''
        },
        body: postToJson(post));
    return response;
  }
}
