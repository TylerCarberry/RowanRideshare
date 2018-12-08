import 'package:flutter/material.dart';

Scaffold launchLoginScreen(
    myController, myController1, myController2, myController3, context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Login'),
    ),
    body: new Column(children: <Widget>[
      new ListTile(
        leading: const Icon(Icons.person),
        title: new TextField(
          controller: myController,
          decoration: new InputDecoration(
            hintText: "First Name",
          ),
          maxLength: 45,
        ),
      ),
      new ListTile(
        leading: const Icon(Icons.person_outline),
        title: new TextField(
          controller: myController1,
          decoration: new InputDecoration(
            hintText: "Last Name",
          ),
          maxLength: 45,
        ),
      ),
      new ListTile(
        leading: const Icon(Icons.email),
        title: new TextField(
          controller: myController2,
          decoration: new InputDecoration(
            hintText: "Email",
          ),
          maxLength: 50,
        ),
      ),
      new ListTile(
        leading: const Icon(Icons.location_city),
        title: new TextField(
          controller: myController3,
          decoration: new InputDecoration(
            hintText: "Location",
          ),
          maxLength: 50,
        ),
      ),
    ]),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      tooltip: 'Show me the value!',
      child: Icon(Icons.text_fields),
    ),
  );
}
