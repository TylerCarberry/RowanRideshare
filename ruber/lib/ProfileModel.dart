import 'dart:convert';

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
  Address2 address;

//  ScheduleList schedules;
  List<Schedule2> schedules;
  double distanceRounded;

//  List<Map<String, dynamic>> schedules;

  Post(
      {this.id,
      this.name,
      this.email,
      this.createdDate,
      this.address,
      this.schedules,
      this.distanceRounded});

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['schedules'] as List;
//    print(list);
    List<Schedule2> scheduleList =
        list.map((i) => Schedule2.fromJsonSchedule(i)).toList();

//    Iterable l = json.decode('scedules');
//    List<Schedule> scheduleList = l.map((Map schedules)=> Schedule.fromJsonSchedule(i)).toList();

    return Post(
      id: parsedJson["id"],
      name: parsedJson["name"],
      email: parsedJson["email"],
      createdDate: parsedJson["createdDate"],
      address: Address2.fromJsonAddress(parsedJson["address"]),
      schedules: scheduleList,
      distanceRounded: parsedJson["distanceRounded"],
//      schedules: json.decode(scheduleList.toString()),
    );
  }

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

//Address2 address2FromJson(String str) {
//  final jsonData = json.decode(str);
//  return Address2.fromJson(jsonData);
//}
//
//String address2ToJson(Address2 data) {
//  final dyn = data.toJson();
//  return json.encode(dyn);
//}

//List<Address2> allAddresses2FromJson(String str) {
//  final jsonData = json.decode(str);
//  return new List<Address2>.from(jsonData.map((x) => Address2.fromJson(x)));
//}
//
//String allAddresses2ToJson(List<Address2> data) {
//  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
//  return json.encode(dyn);
//}

class Address2 {
//  int id;
  String streetAddress;
  String city;
  String zipCode;
  String state;
  double latitude;
  double longitude;

  Address2({
//    this.id,
    this.streetAddress,
    this.city,
    this.zipCode,
    this.state,
    this.latitude,
    this.longitude,
  });

  factory Address2.fromJsonAddress(Map<String, dynamic> json) {
    return Address2(
//      id: parsedJson["id"],
      streetAddress: json["streetAddress"],
      city: json["city"],
      zipCode: json["zipCode"],
      state: json["state"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJsonAddress() => {
//        "id": id,
        "streetAddress": streetAddress,
        "city": city,
        "zipCode": zipCode,
        "state": state,
        "latitude": latitude,
        "longitude": longitude,
      };

//  @override
//  String toString() {
//    return id.toString() + streetAddress.toString() + city + zipCode + state;
//  }
}

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

//class ScheduleList{
//  final List<Schedule> schedules;
//
//  ScheduleList({
//    this.schedules
//  });
//
//  factory ScheduleList.fromJson(List<dynamic> parsedJson) {
//
//    List<Schedule> schedules = new List<Schedule>();
//    schedules = parsedJson.map((i)=>Schedule.fromJsonSchedule(i)).toList();
//    return new ScheduleList(
//      schedules: schedules,
//    );
//  }
//}
