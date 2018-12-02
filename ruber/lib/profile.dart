import 'dart:async';
import 'dart:async' show Future;
import 'dart:io';
import 'package:ruber/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AddressModel.dart';
import 'AppDrawer.dart';
import 'ProfileModel.dart';
import 'editschedule.dart';
import 'AuthScreen.dart';


String streetName = "";
String city = "";
String zipCode = "";
String state = "";

String email = "";

String name = "";
int id;
// SETTERS

setName(String newName) {
  name = newName;
}

setStreetName(String newStreetName) {
  streetName = newStreetName;
}

setCity(String newCity) {
  city = newCity;
}

setNewState(String newState) {
  state = newState;
}

setZip(String newZip) {
  zipCode = newZip;
}

setEmail(String newEmail) {
  email = newEmail;
}



// GETTERS

getName() {
  return name;
}

getStreetName() {
  return streetName;
}

getCity() {
  return city;
}

getZip() {
  return zipCode;
}

getState() {
  return state;
}

getEmail() {
  return email;
}


//getId() async {
//  if(id == 0 || id == null)
//  {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    id = prefs.getInt("id");
//  };
//  return id;
//}

getId() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int tempId = prefs.getInt("id");
  if (tempId != 0 && tempId != null) {
    id = tempId;
  }

  return id;
}

setId(int newId) async {
  if (newId != null && newId != 0) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", newId);
    //print(newId);
    id = newId;
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      drawer: launchAppDrawer(context),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            // Profile Picture

            Container(
                margin: EdgeInsets.only(
                    bottom: 0.0, left: 90.0, right: 90.0, top: 0.0),
                width: 190.0,
                height: 190.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        // This is where we would retrieve the image from the data base
                        image: NetworkImage(userProfilePic)))),

            // Full Name Heading & Text

            Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text('Full Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Helvetica',
                        color: Colors.blueAccent))),
            Container(
                child: Center(
//                    child: FutureBuilder<List<Post>>(
//                        future: getAllPost(),
//                        builder: (context, snapshot) {
//                          if (snapshot.hasData)
//                            return Text(
//                                'matched users ${snapshot.data[1].name}');
//                          else
//                            return CircularProgressIndicator();
//                        }))),
                    child: FutureBuilder<Post>(
                        future: getPost(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return Text('${snapshot.data.name}');
                          else
                            return CircularProgressIndicator();
                        }))),

            // Email Heading & Text

            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text('Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      fontFamily: 'Helvetica',
                      color: Colors.deepOrange)),
            ),
            Container(
                child: Center(
                    child: FutureBuilder<Post>(
//                        future: getPost(),
//                        builder: (context, snapshot) {
//                          if (snapshot.hasData){
//                            print(snapshot.data.schedules);
//                            return Text(
//                                '${snapshot.data.schedules[0].day}');}
//                          else
//                            return CircularProgressIndicator();
//                        }))),
                        future: getPost(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text('${snapshot.data.email}');
                          } else
                            return CircularProgressIndicator();
                        }))),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                'Joined Date',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'Helvetica',
                  color: Colors.teal,
                ),
              ),
            ),

            Container(
                child: Center(
                    child: FutureBuilder<Post>(
                        future: getPost(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text('${snapshot.data.createdDate}');
                          } else
                            return CircularProgressIndicator();
                        }))),
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                'Street Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'Helvetica',
                  color: Colors.orange,
                ),
              ),
            ),

            Container(
                child: Center(
                    child: FutureBuilder<Post>(
                        future: getPost(),
                        builder: (context2, snapshot2) {
                          if (snapshot2.hasData) {
                            String newStreetName =
                                snapshot2.data.address.streetAddress.toString();
                            setStreetName(newStreetName);
                            return Text(
                                '${snapshot2.data.address.streetAddress}');
                          } else
                            return CircularProgressIndicator();
                        }))),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                'City',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'Helvetica',
                  color: Colors.pink,
                ),
              ),
            ),

            Container(
                child: Center(
                    child: FutureBuilder<Post>(
                        future: getPost(),
                        builder: (context2, snapshot2) {
                          if (snapshot2.hasData) {
                            String newCity = snapshot2.data.address.city;
                            setCity(newCity);

                            return Text('${snapshot2.data.address.city}');
                          } else
                            return CircularProgressIndicator();
                        }))),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                'State',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'Helvetica',
                  color: Colors.purple,
                ),
              ),
            ),

            Container(
                child: Center(
                    child: FutureBuilder<Post>(
                        future: getPost(),
                        builder: (context2, snapshot2) {
                          if (snapshot2.hasData) {
                            String newState = snapshot2.data.address.state;
                            setNewState(newState);

                            return Text('${snapshot2.data.address.state}');
                          } else
                            return CircularProgressIndicator();
                        }))),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                'Zip Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'Helvetica',
                  color: Colors.indigo,
                ),
              ),
            ),

            Container(
                child: Center(
                    child: FutureBuilder<Post>(
                        future: getPost(),
                        builder: (context2, snapshot2) {
                          if (snapshot2.hasData) {
                            String newZipCode = snapshot2.data.address.zipCode;
                            setZip(newZipCode);

                            return Text('${snapshot2.data.address.zipCode}');
                          } else
                            return CircularProgressIndicator();
                        }))),

            // Edit buttons

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Edit Address'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddressForm()));
                  },
                ),
                RaisedButton(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Edit Schedule'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleForm()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ========================== EDIT ADDRESS =========================== //

class AddressForm extends StatefulWidget {
  @override
  _MyAddressForm createState() => _MyAddressForm();
}

class _MyAddressForm extends State<AddressForm> {
  final streetNameController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final stateController = TextEditingController();

  String newStreet = "";
  String newCity = "";
  String newZip = "";
  String newState = "";

  @override
  void dispose() {
    streetNameController.dispose();
    cityController.dispose();
    zipController.dispose();
    stateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Edit your address'),
            centerTitle: true,
            automaticallyImplyLeading: false),
        drawer: launchAppDrawer(context),
        body: Center(
            child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                'Click on each field to edit it',
                textAlign: TextAlign.center,
              ),
            ),

            // Email

            Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text('Street Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Helvetica',
                        color: Colors.blueAccent))),
            Container(
                child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(hintText: streetName),
              controller: streetNameController,
              onEditingComplete: () {
                newStreet = streetNameController.text;

                FocusScope.of(context).requestFocus(new FocusNode());
              },
            )),
            Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text('City',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Helvetica',
                        color: Colors.blueAccent))),
            Container(
                child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(hintText: city),
              controller: cityController,
              onEditingComplete: () {
                // Make sure to write to Database

                newCity = cityController.text;

                FocusScope.of(context).requestFocus(new FocusNode());
              },
            )),
            Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text('State',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Helvetica',
                        color: Colors.blueAccent))),
            Container(
                child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(hintText: state),
              controller: stateController,
              onEditingComplete: () {
                // Make sure to write to Database

                newState = stateController.text;

                FocusScope.of(context).requestFocus(new FocusNode());
              },
            )),
            Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text('ZIP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Helvetica',
                        color: Colors.blueAccent))),
            Container(
                child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(hintText: zipCode),
              controller: zipController,
              onEditingComplete: () {
                // Make sure to write to Database
                newZip = zipController.text;

                FocusScope.of(context).requestFocus(new FocusNode());
              },
            )),
            Container(
                margin: EdgeInsets.only(top: 40.0, left: 70.0, right: 70.0),
                child: RaisedButton(
                  child: Text('Save Changes'),
                  onPressed: () {
                    if (streetNameController.text.isEmpty != true) {
                      setStreetName(streetNameController.text);
                    }
                    if (stateController.text.isEmpty != true) {
                      setNewState(stateController.text);
                    }
                    if (cityController.text.isEmpty != true) {
                      setCity(cityController.text);
                    }
                    if (zipController.text.isEmpty != true) {
                      setZip(zipController.text);
                    }

                    String streetNameEdit = getStreetName();
                    String cityNameFinal = getCity();
                    String zipCodeEdit = getZip();
                    String stateEdit = getState();
                    Address newAddress = Address(
                        id: 1,
                        streetAddress: streetNameEdit,
                        city: cityNameFinal,
                        zipCode: zipCodeEdit,
                        state:
                            stateEdit); // creating a new Post object to send it to API

                    createAddress(newAddress).then((response) {
                      if (response.statusCode > 200)
                        print(response.body);
                      else
                        print(response.statusCode);
                    }).catchError((error) {
                      print('error : $error');
                    });

                    print(newAddress.toString());

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ))
          ],
        )));
  }
}

Future<int> getMyId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String emailUrl = prefs.getString("email");

  //String emailUrl = ;  // Need to work on getting email from AuthScreen.dart
  String addressUrl = BASE_URL + '/rides/profile/getmyid/$emailUrl';
  final response2 = await http.get(addressUrl);
  var res = response2.body;
  await setId(int.parse(res));
  print(res);
  return int.parse(res);
}

Future<Post> getPost() async {
  int userid = await getId();
  print(userid);
  print(userid.toString());
  String postUrl = BASE_URL + '/rides/profile/$userid';
  print(postUrl);
  final response = await http.get(postUrl);
  return postFromJson(response.body);
}

Future<Address> getAddressPost() async {
  int id = await getId();
  String addressUrl = BASE_URL + '/rides/address/$id';
  final response2 = await http.get(addressUrl);
  return addressFromJson(response2.body);
}

Future<http.Response> createPost(Post post) async {
  String updateUrl = BASE_URL + '/rides/address/update';
  final response = await http.post('$updateUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: postToJson(post));
  return response;
}

Future<http.Response> createAddress(Address address) async {
  String updateUrl = BASE_URL + '/rides/address/update';
  final response = await http.post('$updateUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: addressToJson(address));
  return response;
}

Future<List<Post>> getAllPost() async {
  String postUrl = BASE_URL + '/rides/matching/3/20';
  final response = await http.get(postUrl);
  return allPostsFromJson(response.body);
}
