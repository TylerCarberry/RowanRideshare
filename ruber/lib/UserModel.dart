import 'dart:convert';

//Takes in a NewUser object and returns a JSON String
String userToJson(NewUser data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Takes in a JSON String and converts it to a NewUser object
NewUser userFromJson(String str) {
  final jsonData = json.decode(str);
  return NewUser.fromJson(jsonData);
}

//Class that handles the creation of a new user
class NewUser {
  String name;
  String email;

  //Constructor for NewUser has a name and email
  NewUser({
    this.name,
    this.email,
  });

  //Converts the JSON to a NewUser
  factory NewUser.fromJson(Map<String, dynamic> parsedJson) {
    return NewUser(
      name: parsedJson["name"],
      email: parsedJson["email"],
    );
  }

  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };
}