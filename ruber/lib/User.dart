//This class sets up parsing from a nested list, every variable will be added in the next commit
class User {
  String userId;
  String userName;
  int userEmail;
  Address address;

  User({
    this.userId,
    this.userName,
    this.userEmail,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        userName: parsedJson['name'],
        address: Address.fromJson(parsedJson['address']));
  }
}

class Address {
  int id;

  Address({
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
    );
  }
}
