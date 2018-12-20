import 'dart:convert';

//Takes in a JSON string and converts it to a Post object
Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

//Takes in a Post object and returns a JSON String
String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Returns a list of all Posts from a JSON String
List<Post> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Post>.from(jsonData.map((x) => Post.fromJson(x)));
}

//Converts a List of Posts to a Json String
String allPostsToJson(List<Post> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

//Class that creates a Post object
class Post {
  int id;
  String name;
  String email;
  String createdDate;
  Address2 address;
  List<Schedule2> schedules;
  double distanceRounded;

  //Class that creates a Post
  Post(
      {this.id,
        this.name,
        this.email,
        this.createdDate,
        this.address,
        this.schedules,
        this.distanceRounded});

  //Converts JSON to a Post object
  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['schedules'] as List;
    List<Schedule2> scheduleList =
    list.map((i) => Schedule2.fromJsonSchedule(i)).toList();
    return Post(
      id: parsedJson["id"],
      name: parsedJson["name"],
      email: parsedJson["email"],
      createdDate: parsedJson["createdDate"],
      address: Address2.fromJsonAddress(parsedJson["address"]),
      schedules: scheduleList,
      distanceRounded: parsedJson["distanceRounded"],
    );
  }

  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "createdDate": createdDate,
    "address": address,
    "schedules": schedules,
    "distanceRounded": distanceRounded
  };
}

//Class used to parse the nested Address objects
class Address2 {String streetAddress;
String city;
String zipCode;
String state;
double latitude;
double longitude;

Address2({
  this.streetAddress,
  this.city,
  this.zipCode,
  this.state,
  this.latitude,
  this.longitude,
});

factory Address2.fromJsonAddress(Map<String, dynamic> json) {
  return Address2(
    streetAddress: json["streetAddress"],
    city: json["city"],
    zipCode: json["zipCode"],
    state: json["state"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );
}

Map<String, dynamic> toJsonAddress() => {
  "streetAddress": streetAddress,
  "city": city,
  "zipCode": zipCode,
  "state": state,
  "latitude": latitude,
  "longitude": longitude,
};
}

//Class used to parse the nested Schedule objects
class Schedule2 {
  int id;
  int profile;
  String day;
  String goingToRangeStart;
  String goingToRangeEnd;
  String leavingRangeStart;
  String leavingRangeEnd;

  Schedule2({
    this.id,
    this.profile,
    this.day,
    this.goingToRangeStart,
    this.goingToRangeEnd,
    this.leavingRangeStart,
    this.leavingRangeEnd,
  });

  factory Schedule2.fromJsonSchedule(Map<String, dynamic> parsedJson) {
    return Schedule2(
      id: parsedJson['id'],
      profile: parsedJson['profile'],
      day: parsedJson['day'],
      goingToRangeStart: parsedJson['goingToRangeStart'],
      goingToRangeEnd: parsedJson['goingToRangeEnd'],
      leavingRangeStart: parsedJson['leavingRangeStart'],
      leavingRangeEnd: parsedJson['leavingRangeEnd'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile,
    "day": day,
    "goingToRangeStart": goingToRangeStart,
    "goingToRangeEnd": goingToRangeEnd,
    "leavingRangeStart": leavingRangeStart,
    "leavingRangeEnd": leavingRangeEnd,
  };
}