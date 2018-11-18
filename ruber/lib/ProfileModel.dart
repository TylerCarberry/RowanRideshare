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
  Address2 address;
  var schedules;
//  List<Map<String, dynamic>> schedules;

  Post({
    this.id,
    this.name,
    this.email,
    this.createdDate,
    this.address,
    this.schedules,
  });

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return Post(
      id: parsedJson["id"],
      name: parsedJson["name"],
      email: parsedJson["email"],
      createdDate: parsedJson["createdDate"],
//      address: parsedJson["address"],
      address: Address2.fromJsonAddress(parsedJson["address"]),
      schedules: parsedJson["schedules"],
    );}

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "email": email,
        "createdDate": createdDate,
        "address": address,
        "schedules": schedules,
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

class Address2{
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
    );}

  Map<String, dynamic> toJsonAddress() =>
      {
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