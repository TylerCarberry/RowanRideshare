import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Rest.dart';
import 'initialeditschedule.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'ProfileModel.dart';
import 'AddressModel.dart';
import 'dart:io';
import 'AuthScreen.dart';
import 'AddressPostModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

int id;
String profilePic;
String streetName = "";
String city = "";
String zipCode = "";
String state = "";

String email = "";
String name = "";

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
    id = newId;
  }
}



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

setProfilePic(String picLocation) {
  profilePic = picLocation;
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


getProfilePic() {
  return profilePic;
}

class InitialAddressForm extends StatefulWidget {
  final String emailAddress;
  InitialAddressForm(this.emailAddress);



  @override
  _MyAddressForm createState() => _MyAddressForm();

}

class _MyAddressForm extends State<InitialAddressForm> {


  final streetNameController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final stateController = TextEditingController();

  String newStreet = "";
  String newCity = "";
  String newZip = "";
  String newState = "";

  bool a = false;
  bool b = false;
  bool c = false;
  bool d = false;

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
    print(email);
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
                    // TODO: Fix the capture of fields -- current output is null201 mullica Hill roadglassboro08043NJ

                    if (streetNameController.text.isEmpty != true) {
                      setStreetName(streetNameController.text);
                      a = true;
                    }
                    if (stateController.text.isEmpty != true) {
                      setNewState(stateController.text);
                      b = true;
                    }
                    if (cityController.text.isEmpty != true) {
                      setCity(cityController.text);
                      c = true;
                    }
                    if (zipController.text.isEmpty != true) {
                      setZip(zipController.text);
                      d = true;
                    }

                    // Only activates after all the fields have information in them
                    if (true || (a && b && c && d) == true) {
                      String streetNameEdit = getStreetName();
                      String cityNameFinal = getCity();
                      String zipCodeEdit = getZip();
                      String stateEdit = getState();
                      AddressPost newAddress = AddressPost(
                          streetAddress: streetNameEdit,
                          city: cityNameFinal,
                          zipCode: zipCodeEdit,
                          state: stateEdit); // creating a new Post object to send it to API

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
                        MaterialPageRoute(builder: (context) => InitialScheduleForm()),
                      );
                    } else {
                      return null;
                    }
                  },
                )),

            Container(
                child: Center(
                    child: FutureBuilder<int>(
                        future: getMyId(),
                        builder: (context2, snapshot2) {
                          if (snapshot2.hasData) {
                            int tempId = snapshot2.data;

                            print(tempId);
                            setId(tempId);
                            return Text(
                                '${snapshot2.data.toString()}');
                          }
                          else
                            return CircularProgressIndicator();
                        }))),

          ],
        )));
  }
}


Future<int> getMyId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String emailUrl = prefs.getString("email");

  //String emailUrl = ;  // Need to work on getting email from AuthScreen.dart
  String addressUrl = 'http://10.0.2.2:8080/rides/profile/getmyid/$emailUrl';
  final response2 = await http.get(addressUrl);
  var res = response2.body;
  await setId(int.parse(res));
  print(res);
  return int.parse(res);
}


Future<http.Response> createAddress(AddressPost address) async {
  int userId = await getId();
  String updateUrl = 'http://10.0.2.2:8080/rides/address/$userId/new';
  final response = await http.post('$updateUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: addressPostToJson(address));
  return response;
}

/*
Future<Post> getMyAddressId() async {
  String emailUrl = getEmailAddress();
  String addressUrl = 'http://10.0.2.2:8080/rides/profile/email/$emailUrl';
  final response2 = await http.get(addressUrl);
  return postFromJson(response2.body);
}

*/