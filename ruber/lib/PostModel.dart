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
  //Address address;
  String createdDate;
  var schedules;

  Post({
    this.id,
    this.name,
    this.email,
    //this.address,
    this.createdDate,
    this.schedules,
  });

  factory Post.fromJson(Map<String, dynamic> json) =>
      new Post(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        //address: json["address"],
        createdDate: json["createdDate"],
        schedules: json["schedules"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "email": email,
        //"address": address,
        "createdDate": createdDate,
        "schedules": schedules,
      };
}


/*
class Address {
  int id2;
  String streetAddress;
  String city;
  int zipCode;
  String state;
  double latitude;
  double longitude;

  Address({
    this.id2,
    this.streetAddress,
    this.city,
    this.zipCode,
    this.state,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => new Address(
    id2: json["id"],
    streetAddress: json["streetAddress"],
    city: json["city"],
    zipCode: json["zipCode"],
    state: json["state"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id2,
    "streetAddress": streetAddress,
    "city": city,
    "zipCode": zipCode,
    "state": state,
    "latitude": latitude,
    "longitude": longitude,
  };
}
*/