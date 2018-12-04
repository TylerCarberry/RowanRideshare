/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'ProfileModel.dart';
import 'dart:io';
import 'AddressModel.dart';


String hello = "hi";
Address newAddress = new Address(id: 1, streetAddress: hello);

class Rest extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
            child: Center(
              child: FutureBuilder<Address>(
                  future: getAddress(),
                  builder: (context, snapshot) {



                    if (snapshot.hasData)
                      {


                      return Text(
                          'Created Date from Post JSON : ${snapshot.data.streetAddress}');
                      }
                    else
                      return CircularProgressIndicator();
                  })),
        ),
      ),
    );
  }

  String url = BASE_URL + '/rides/address/1';

  Future<List<Post>> getAllPosts() async {
    final response = await http.get(url);
    print(response.body);
    return allPostsFromJson(response.body);
  }

  Future<Address> getAddress() async {
    final response = await http.get(url);
    return addressFromJson(response.body);
  }

  Future<http.Response> createAddress(Address address) async {
    final response = await http.post('$url',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: ''
        },
        body: addressToJson(address));
    return response;
  }



}
*/
