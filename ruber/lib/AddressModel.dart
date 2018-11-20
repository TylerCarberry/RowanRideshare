import 'dart:convert';

Address addressFromJson(String str) {
  final jsonData = json.decode(str);
  return Address.fromJson(jsonData);
}

String addressToJson(Address data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Address> allAddressesFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Address>.from(jsonData.map((x) => Address.fromJson(x)));
}

String allAddressesToJson(List<Address> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Address {
  int id;
  String streetAddress;
  String city;
  String zipCode;
  String state;
  double latitude;
  double longitude;

  Address({
    this.id,
    this.streetAddress,
    this.city,
    this.zipCode,
    this.state,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> parsedJson) {
    return Address(
      id: parsedJson["id"],
      streetAddress: parsedJson["streetAddress"],
      city: parsedJson["city"],
      zipCode: parsedJson["zipCode"],
      state: parsedJson["state"],
      latitude: parsedJson["latitude"],
      longitude: parsedJson["longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "streetAddress": streetAddress,
        "city": city,
        "zipCode": zipCode,
        "state": state,
        "latitude": latitude,
        "longitude": longitude,
      };

  @override
  String toString() {
    return id.toString() + streetAddress.toString() + city + zipCode + state;
  }
}
