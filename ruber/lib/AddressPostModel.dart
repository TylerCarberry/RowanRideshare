import 'dart:convert';

//Takes in a JSON String and converts it an AddressPost object
AddressPost addressFromJson(String str) {
  final jsonData = json.decode(str);
  return AddressPost.fromJson(jsonData);
}

//Takes in an AddressPost object and returns a JSON String
String addressPostToJson(AddressPost data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Returns a list of all AddressPost's from a JSON String
List<AddressPost> allAddressesFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<AddressPost>.from(
      jsonData.map((x) => AddressPost.fromJson(x)));
}

//Class that makes up what is required to post an Address
class AddressPost {
  String streetAddress;
  String city;
  String zipCode;
  String state;

  //Constructor for an AddressPost object
  AddressPost({
    this.streetAddress,
    this.city,
    this.zipCode,
    this.state,
  });

  //Converts the JSON to an AddressPost
  factory AddressPost.fromJson(Map<String, dynamic> parsedJson) {
    return AddressPost(
      streetAddress: parsedJson["streetAddress"],
      city: parsedJson["city"],
      zipCode: parsedJson["zipCode"],
      state: parsedJson["state"],
    );
  }

  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "streetAddress": streetAddress,
    "city": city,
    "zipCode": zipCode,
    "state": state,
  };
}