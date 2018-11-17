import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'editschedule.dart';
import 'Rest.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'ProfileModel.dart';
import 'AddressModel.dart';
import 'dart:io';
import 'editschedule.dart';

String profilePic;
String streetName = "";
String city = "";
String zipCode = "";
String state = "";

String email = "";
String name = "";

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

getEmail() {
  return email;
}

getProfilePic() {
  return profilePic;
}

class InitialAddressForm extends StatefulWidget {
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
                      MaterialPageRoute(builder: (context) => ScheduleForm()),
                    );
                  },
                ))
          ],
        )));
  }
}

Future<Post> getPost() async {
  String postUrl = 'http://10.0.2.2:8080/rides/profile/1';
  final response = await http.get(postUrl);
  return postFromJson(response.body);
}

Future<Address> getAddressPost() async {
  String addressUrl = 'http://10.0.2.2:8080/rides/address/1';
  final response2 = await http.get(addressUrl);
  return addressFromJson(response2.body);
}

Future<http.Response> createAddress(Address address) async {
  String updateUrl = 'http://10.0.2.2:8080/rides/address/new';
  final response = await http.post('$updateUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: addressToJson(address));
  return response;
}
