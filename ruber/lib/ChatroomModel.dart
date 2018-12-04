import 'dart:convert';
ChatList listFromJsonChat(String str) {
  final jsonData = json.decode(str);
  //print(jsonData);
  //print(ChatList.fromJson(jsonData));
  return ChatList.fromJsonChat(jsonData);
}
String listToJsonChat(ChatList data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

String messagePostToJson(Messages data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


String chatroomPostToJson(ChatRoom data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<ChatList> allChatsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ChatList>.from(jsonData.map((x) => ChatList.fromJsonChat(x)));
}
String allPostsToJson(List<ChatList> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}
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
    //print(list);
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
      //emails: Email.fromJsonEmail(parsedJson["email"]),
      lastMessageId: parsedJson['lastMessageId'],
    );
  }
  Map<String, dynamic> toJson() => {
    "chatRoomId": chatRoomId,
    "createdDate": createdDate,
    "messages": messages,
    "profileIDs": profileIDs,
    "profileNames": profileNames,
    "profileOneID":profileOneID,
    "profileTwoID":profileTwoID,
    //"emails": emails,
    "lastMessageId": lastMessageId,
  };
}
class Messages {
//  int id;
//  int senderId;
  int chatroomID;
  int senderID;
  String text;
  String timeSent;
  Messages({
//    this.id,
//    this.senderId,
    this.chatroomID,
    this.senderID,
    this.text,
    this.timeSent,
  });
  factory Messages.fromJsonGetMessages(Map<String, dynamic> parsedJson) {
    return Messages(
//      id:parsedJson['id'],
//      senderId: parsedJson['senderId'],
      chatroomID: parsedJson['chatroomID'],
      senderID: parsedJson['senderID'],
      text: parsedJson['text'],
      timeSent: parsedJson['timeSent'],
    );
  }
  Map<String, dynamic> toJson() => {
//    "id:": id,
//    "senderId":senderId,
    "chatroomID": chatroomID,
    "senderID": senderID,
    "text": text,
    "timeSent": timeSent,
  };
}
class GetMessage{
  int id;
//  int senderId;
//  int chatroomID;
  int senderID;
  String text;
  String timeSent;

  GetMessage({
    this.id,
//    this.senderId,
//    this.chatroomID,
    this.senderID,
    this.text,
    this.timeSent,
  });
  factory GetMessage.fromJsonGetMessages(Map<String, dynamic> parsedJson) {
    return GetMessage(
      id:parsedJson['id'],
//      senderId: parsedJson['senderId'],
//      chatroomID: parsedJson['chatroomID'],
      senderID: parsedJson['senderID'],
      text: parsedJson['text'],
      timeSent: parsedJson['timeSent'],
    );
  }
  Map<String, dynamic> toJson() => {
    "id:": id,
//    "senderId":senderId,
//    "chatroomID": chatroomID,
    "senderID": senderID,
    "text": text,
    "timeSent": timeSent,
  };
}
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
class ProfileNames {
  String profile1;
  String profile2;
  ProfileNames({
    this.profile1,
    this.profile2,
  });
  factory ProfileNames.fromJsonNames(Map<String, dynamic> parsedJson) {
    return ProfileNames(
      profile1: parsedJson['Profile 1'],
      profile2: parsedJson['Profile 2'],
    );
  }
  Map<String, dynamic> toJson() => {
    "Profile 1": profile1,
    "Profile 2": profile2,
  };
}
/*
class Email {
  String profile1;
  String profile2;
  Email({
    this.profile1,
    this.profile2,
  });
  factory Email.fromJsonEmail(Map<String, dynamic> parsedJson) {
    return Email(
      profile1: parsedJson['Profile 1'],
      profile2: parsedJson['Profile 2'],
    );
  }
  Map<String, dynamic> toJson() => {
    "Profile 1": profile1,
    "Profile 2": profile2,
  };
}
*/