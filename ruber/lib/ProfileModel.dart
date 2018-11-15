import 'dart:convert';
import 'AddressModel.dart';


Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Post> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Post>.from(jsonData.map((x) => Post.fromJson(x)));
}

String allPostsToJson(List<Post> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Post {
  int id;
  String name;
  String email;
  String createdDate;
  var schedules;

  Post({
    this.id,
    this.name,
    this.email,
    this.createdDate,
    this.schedules,
  });

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
      return Post(
        id: parsedJson["id"],
        name: parsedJson["name"],
        email: parsedJson["email"],
        createdDate: parsedJson["createdDate"],
        schedules: parsedJson["schedules"],
      );}

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "email": email,
        "createdDate": createdDate,
        "schedules": schedules,
      };
}