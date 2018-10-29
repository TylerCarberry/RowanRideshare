import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'Rest.dart';

String profilepic;

String streetname = "1007 Mountain Drive";
String city = "Gotham";
String zip = "53540";
String state = "CA";
String schedule = "Working on this";
String fullAddress = "";

String email = "wayne@wayneenterprises.com";
String name = "Bruce Wayne";

// SETTERS

setName(String newName) {
  name = newName;
}

setFullAddress(String newFullAddress) {
  fullAddress = newFullAddress;
}

@override
setFullAddressWithParams(
    String newStreetName, String newCity, String newZip, String newState) {
  fullAddress = streetname + ", " + city + ", " + state + " " + zip;
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

setState(String newState) {
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

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setProfilePic(
        "https://i.etsystatic.com/6543599/r/il/0dabd7/447283695/il_570xN.447283695_g8gh.jpg");

    String fullAddress = streetname + ", " + city + ", " + state + " " + zip;

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
                  email,
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

//            // Schedule
//
//            Container(
//              margin: EdgeInsets.only(top: 15.0),
//              child: Text(
//                'Schedule',
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 20.0,
//                  fontFamily: 'Helvetica',
//                  color: Colors.purpleAccent,
//                ),
//              ),
//            ),
//            Container(
//                margin: EdgeInsets.all(5.0),
//                child: Text(
//                  schedule,
//                  textAlign: TextAlign.center,
//                  style: TextStyle(fontSize: 16.0),
//                )),

            // Edit buttons

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Edit Name'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullNameForm()));
                  },
                ),
                RaisedButton(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Edit Email'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EmailForm()));
                    }),
                RaisedButton(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Edit Address'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddressForm()));
                  },
                ),
//                RaisedButton(
//                    padding: EdgeInsets.all(5.0),
//                    child: Text('Edit Schedule'),
//                    onPressed: () {
//                      print("I'm working on it");
//                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ========================= EDIT FULL NAME ========================== /

class FullNameForm extends StatefulWidget {
  @override
  _MyFullNameForm createState() => _MyFullNameForm();
}

class _MyFullNameForm extends State<FullNameForm> {
  final fullNameController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your full name'),
        centerTitle: true,
      ),
      drawer: launchAppDrawer(context),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                'Click on each to edit it',
                textAlign: TextAlign.center,
              ),
            ),

            // Full Name

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
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration.collapsed(
                  hintText: name,
                ),
                controller: fullNameController,
                onEditingComplete: () {
                  // Make sure to write to Database

                  setName(fullNameController.text);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====================== END EDIT FULL NAME ========================== //

// ====================== EDIT EMAIL ADDRESS ========================== //

class EmailForm extends StatefulWidget {
  @override
  _MyEmailForm createState() => _MyEmailForm();
}

class _MyEmailForm extends State<EmailForm> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Edit your email'), centerTitle: true),
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
                    child: Text('Email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'Helvetica',
                            color: Colors.blueAccent))),
                Container(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration.collapsed(hintText: email),
                      controller: emailController,
                      onEditingComplete: () {
                        // Make sure to write to Database

                        setEmail(emailController.text);
                        Navigator.pop(context);
                      },
                    ))
              ],
            )));
  }
}

// ========================== END EDIT EMAIL ADDRESS ================= //

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

  @override
  void dispose() {
    streetNameController.dispose();
    cityController.dispose();
    zipController.dispose();
    stateController.dispose();

    super.dispose();
  }

  // TODO -- Work on entering the whole address separately and it combining together without having to do each one at a time

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Edit your address'), centerTitle: true),
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

                        setFullAddressWithParams(
                            getStreetName(), getCity(), getState(), getZip());
                        setStreetName(streetNameController.text);
                        Navigator.pop(context);
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
                        setFullAddressWithParams(
                            getStreetName(), getCity(), getState(), getZip());
                        setCity(cityController.text);
                        Navigator.pop(context);
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
                        setFullAddressWithParams(
                            getStreetName(), getCity(), getState(), getZip());
                        setState(stateController.text);
                        Navigator.pop(context);
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

                        setFullAddressWithParams(
                            getStreetName(), getCity(), getState(), getZip());
                        setZip(zipController.text);
                        Navigator.pop(context);
                      },
                    )),
              ],
            )));
  }
}
