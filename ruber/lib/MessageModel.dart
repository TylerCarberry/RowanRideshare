import 'dart:convert';


Message messageFromJson(String str) {
  final jsonData = json.decode(str);
  return Message.fromJson(jsonData);
}

String messageToJson(Message data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Message> allMessagesFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Message>.from(jsonData.map((x) => Message.fromJson(x)));
}

String allMessagessToJson(List<Message> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Message {
  int id;
  var chatroom;
  int senderID;
  String text;
  var timeSent;

  Message({
    this.id,
    this.chatroom,
    this.senderID,
    this.text,
    this.timeSent,
  });

  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
      id: parsedJson["id"],
      chatroom: parsedJson["chatroom"],
      senderID: parsedJson["senderID"],
      text: parsedJson["text"],
      timeSent: parsedJson["timeSent"],
    );}

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "chatroom": chatroom,
        "senderID": senderID,
        "text": text,
        "timeSent": timeSent,
      };
}