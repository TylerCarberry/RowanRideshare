import 'dart:convert';

//Takes in a JSON string and converts it to a ChatList object
ChatList listFromJsonChat(String str) {
  final jsonData = json.decode(str);
  //print(jsonData);
  //print(ChatList.fromJson(jsonData));
  return ChatList.fromJsonChat(jsonData);
}

//Takes in a ChatList object and returns a JSON String
String listToJsonChat(ChatList data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Takes in a Messages object and returns a JSON String
String messagePostToJson(Messages data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Takes in a Chatroom object and returns a JSON String
String chatroomPostToJson(ChatRoom data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Returns a list of all ChatList objects from a JSON String
List<ChatList> allChatsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ChatList>.from(jsonData.map((x) => ChatList.fromJsonChat(x)));
}

//Converts a List of ChatList objects to a JSON String
String allPostsToJson(List<ChatList> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

//Class that shows all Chats
class ChatList {
  List<ChatRoom> chatrooms;
  ChatList(
      {this.chatrooms});
  factory ChatList.fromJsonChat(Map<String, dynamic> parsedJson) {
    var list = parsedJson['chatrooms'] as List;
    //print(list);
    List<ChatRoom> chatRoomList =
    list.map((i) => ChatRoom.fromJsonChatRoom(i)).toList();
    return ChatList(
      chatrooms: chatRoomList,
    );
  }
  Map<String, dynamic> toJson() => {
    "chatrooms": chatrooms,
  };
}

//A Chatroom class that structures communication between two users
class ChatRoom {
  int chatRoomId;
  String createdDate;
  List<GetMessage> messages;
  ProfileIDs profileIDs;
  int profileOneID;
  int profileTwoID;
  ProfileNames profileNames;
  int lastMessageId;
  ChatRoom({
    this.chatRoomId,
    this.createdDate,
    this.messages,
    this.profileIDs,
    this.profileNames,
    this.profileOneID,
    this.profileTwoID,
    this.lastMessageId,
  });
  factory ChatRoom.fromJsonChatRoom(Map<String, dynamic> parsedJson) {
    var list = parsedJson['messages'] as List;
    List<GetMessage> messageList =
    list.map((i) => GetMessage.fromJsonGetMessages(i)).toList();
    return ChatRoom(
      chatRoomId: parsedJson['chatRoomId'],
      createdDate: parsedJson['createdDate'],
      messages: messageList,
      profileIDs: ProfileIDs.fromJsonIDs(parsedJson["profileIDs"]),
      profileNames: ProfileNames.fromJsonNames(parsedJson["profileNames"]),
      profileOneID: parsedJson['profileOneID'],
      profileTwoID: parsedJson['profileTwoID'],
      lastMessageId: parsedJson['lastMessageId'],
    );
  }

  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "chatRoomId": chatRoomId,
    "createdDate": createdDate,
    "messages": messages,
    "profileIDs": profileIDs,
    "profileNames": profileNames,
    "profileOneID":profileOneID,
    "profileTwoID":profileTwoID,
    "lastMessageId": lastMessageId,
  };
}

//Class that creates a Messages object
class Messages {
  int chatroomID;
  int senderID;
  String text;
  String timeSent;

  //Constructor for a message object
  Messages({
    this.chatroomID,
    this.senderID,
    this.text,
    this.timeSent,
  });

  //Converts the JSON to a Message
  factory Messages.fromJsonGetMessages(Map<String, dynamic> parsedJson) {
    return Messages(
      chatroomID: parsedJson['chatroomID'],
      senderID: parsedJson['senderID'],
      text: parsedJson['text'],
      timeSent: parsedJson['timeSent'],
    );
  }
  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "chatroomID": chatroomID,
    "senderID": senderID,
    "text": text,
    "timeSent": timeSent,
  };
}

//Class to get the text of a chat message
class GetMessage{
  int id;
  int senderID;
  String text;
  String timeSent;

  //Constructs a GetMessage object that gives id, senderID, text, and timeSent
  GetMessage({
    this.id,
    this.senderID,
    this.text,
    this.timeSent,
  });

  //Converts the JSON to a GetMessage
  factory GetMessage.fromJsonGetMessages(Map<String, dynamic> parsedJson) {
    return GetMessage(
      id:parsedJson['id'],
      senderID: parsedJson['senderID'],
      text: parsedJson['text'],
      timeSent: parsedJson['timeSent'],
    );
  }

  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "id:": id,
    "senderID": senderID,
    "text": text,
    "timeSent": timeSent,
  };
}

//Class that allows parsing of the profile ID's in chatroom
class ProfileIDs {
  int profile1;
  int profile2;
  ProfileIDs({
    this.profile1,
    this.profile2,
  });
  factory ProfileIDs.fromJsonIDs(Map<String, dynamic> parsedJson) {
    return ProfileIDs(
      profile1: parsedJson['Profile 1'],
      profile2: parsedJson['Profile 2'],
    );
  }
  Map<String, dynamic> toJson() => {
    "Profile 1": profile1,
    "Profile 2": profile2,
  };
}

//Constructor for a ProfileNames object
class ProfileNames {
  String profile1;
  String profile2;
  ProfileNames({
    this.profile1,
    this.profile2,
  });

  //Converts the JSON to a ProfileNames object
  factory ProfileNames.fromJsonNames(Map<String, dynamic> parsedJson) {
    return ProfileNames(
      profile1: parsedJson['Profile 1'],
      profile2: parsedJson['Profile 2'],
    );
  }

  //Converts the data to JSON
  Map<String, dynamic> toJson() => {
    "Profile 1": profile1,
    "Profile 2": profile2,
  };
}