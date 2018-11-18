import 'dart:convert';


String userToJson(NewUser data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


NewUser userFromJson(String str) {
  final jsonData = json.decode(str);
  return NewUser.fromJson(jsonData);
}

class NewUser {

  String name;
  String email;


  NewUser({
    this.name,
    this.email,

  });

  factory NewUser.fromJson(Map<String, dynamic> parsedJson) {
    return NewUser(
      name: parsedJson["name"],
      email: parsedJson["email"],
    );}

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "email": email,
      };
}