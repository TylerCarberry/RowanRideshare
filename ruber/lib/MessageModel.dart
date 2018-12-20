import 'dart:convert';

//Takes in a JSON string and converts it to a Message object
Message messageFromJson(String str) {
  final jsonData = json.decode(str);
  return Message.fromJson(jsonData);
}

//Takes in a Message object and returns a JSON String
String messageToJson(Message data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Returns a list of all Messages from a JSON String
List<Message> allMessagesFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Message>.from(jsonData.map((x) => Message.fromJson(x)));
}

//Converts a List of Messages to a Json String
String allMessagessToJson(List<Message> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

//Class that creates a Message object that allows users to communicate
class Message {
  int id;
  var chatroom;
  int senderID;
  String text;
  var timeSent;

  //Constructor for a Message that has id, chatroom, senderID, text, and timeSent
  Message({
    this.id,
    this.chatroom,
    this.senderID,
    this.text,
    this.timeSent,
  });

  //Converts a JSON to a Message
  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
      id: parsedJson["id"],
      chatroom: parsedJson["chatroom"],
      senderID: parsedJson["senderID"],
      text: parsedJson["text"],
      timeSent: parsedJson["timeSent"],
    );
  }

  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "chatroom": chatroom,
    "senderID": senderID,
    "text": text,
    "timeSent": timeSent,
  };
}