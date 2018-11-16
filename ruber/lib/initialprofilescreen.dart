// TODO -- Work on the initial profile screen, and the schedule input
// TODO -- require address, then only continue, then take them to schedule edit screen

import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Rest.dart';

/***
 * Need to pull all this information from the backend
 */

String profilepic;
String streetname = "1007 Mountain Drive";
String city = "Gotham";
String zip = "53540";
String state = "CA";
String schedule = "Working on this";
String fullAddress =
fullAddress = streetname + ", " + city + ", " + state + " " + zip;

String email = "wayne@wayneenterprises.com";
String name = "Bruce Wayne";

// SETTERS

setName(String newName) {
  name = newName;
}

setFullAddress(String newFullAddress) {
  fullAddress = newFullAddress;
}

setFullAddressWithParams(
    String newStreetName, String newCity, String newZip, String newState) {
  fullAddress = newStreetName + ", " + newCity + ", " + newState + " " + newZip;
}

setStreetName(String newStreetName) {
  streetname = newStreetName;
}

setCity(String newCity) {
  city = newCity;
}

setZip(String newZip) {
  zip = newZip;
}

setNewState(String newState) {
  state = newState;
}

setEmail(String newEmail) {
  email = newEmail;
}

setProfilePic(String picLocation) {
  profilepic = picLocation;
}

// GETTERS

getName() {
  return name;
}

getFullAddress() {
  return fullAddress;
}

getStreetName() {
  return streetname;
}

getCity() {
  return city;
}

getZip() {
  return zip;
}

getState() {
  return state;
}

getEmail() {
  return email;
}

getProfilePic() {
  return profilepic;
}

class InitialProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setProfilePic(
        "https://i.etsystatic.com/6543599/r/il/0dabd7/447283695/il_570xN.447283695_g8gh.jpg");

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
                        image: NetworkImage(profilepic)))),

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
              margin: EdgeInsets.all(5.0),
              child: Text(
                getName(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),

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
                margin: EdgeInsets.all(5.0),
                child: Text(
                  getEmail(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                )),

            // Address Heading & Text

            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                'Home Address',
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
                margin: EdgeInsets.all(5.0),
                child: Text(
                  fullAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                )),

            // Edit address button

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
                      decoration: InputDecoration.collapsed(hintText: streetname),
                      controller: streetNameController,
                      onEditingComplete: () {
                        // Make sure to write to Database

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
                      decoration: InputDecoration.collapsed(hintText: zip),
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
                        // Make sure to write to the database only
                        // if the address has changed

                        // TODO Make sure to write to the database
                        // TODO ONLY INSIDE the if loops, only if the data changed

                        if (streetNameController.text.isEmpty != true) {
                          setStreetName(streetNameController.text);
                          setFullAddressWithParams(
                              getStreetName(), getCity(), getZip(), getState());
                        }

                        if (cityController.text.isEmpty != true) {
                          setCity(cityController.text);
                          setFullAddressWithParams(
                              getStreetName(), getCity(), getZip(), getState());
                        }

                        if (zipController.text.isEmpty != true) {
                          setZip(zipController.text);
                          setFullAddressWithParams(
                              getStreetName(), getCity(), getZip(), getState());
                        }

                        if (stateController.text.isEmpty != true) {
                          setNewState(stateController.text);
                          setFullAddressWithParams(
                              getStreetName(), getCity(), getZip(), getState());
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InitialProfileScreen()),
                        );
                      },
                    ))
              ],
            )));
  }
}

