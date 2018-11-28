import 'dart:convert';

AddressPost addressFromJson(String str) {
  final jsonData = json.decode(str);
  return AddressPost.fromJson(jsonData);
}

String addressPostToJson(AddressPost data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<AddressPost> allAddressesFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<AddressPost>.from(
      jsonData.map((x) => AddressPost.fromJson(x)));
}

class AddressPost {
  String streetAddress;
  String city;
  String zipCode;
  String state;

  AddressPost({
    this.streetAddress,
    this.city,
    this.zipCode,
    this.state,
  });

  factory AddressPost.fromJson(Map<String, dynamic> parsedJson) {
    return AddressPost(
      streetAddress: parsedJson["streetAddress"],
      city: parsedJson["city"],
      zipCode: parsedJson["zipCode"],
      state: parsedJson["state"],
    );
  }

  Map<String, dynamic> toJson() => {
        "streetAddress": streetAddress,
        "city": city,
        "zipCode": zipCode,
        "state": state,
      };
}
