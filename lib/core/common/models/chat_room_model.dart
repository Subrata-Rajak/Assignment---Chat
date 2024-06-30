// To parse this JSON data, do
//
//     final chatRoomModel = chatRoomModelFromJson(jsonString);

import 'dart:convert';

ChatRoomModel chatRoomModelFromJson(String str) =>
    ChatRoomModel.fromJson(json.decode(str));

String chatRoomModelToJson(ChatRoomModel data) => json.encode(data.toJson());

class ChatRoomModel {
  String chatroomId;
  UserType userOne;
  UserType userTwo;
  List<Chat> chats;
  DateTime createdAt;

  ChatRoomModel({
    required this.chatroomId,
    required this.userOne,
    required this.userTwo,
    required this.chats,
    required this.createdAt,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        chatroomId: json["chatroomId"],
        userOne: UserType.fromJson(json["userOne"]),
        userTwo: UserType.fromJson(json["userTwo"]),
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "chatroomId": chatroomId,
        "userOne": userOne.toJson(),
        "userTwo": userTwo.toJson(),
        "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
      };
}

class Chat {
  String userId;
  String text;
  DateTime timeStamp;

  Chat({
    required this.userId,
    required this.text,
    required this.timeStamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        userId: json["userId"],
        text: json["text"],
        timeStamp: DateTime.parse(json["timeStamp"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "text": text,
        "timeStamp": timeStamp.toIso8601String(),
      };
}

class UserType {
  String username;
  String email;
  String uid;

  UserType({
    required this.username,
    required this.email,
    required this.uid,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        username: json["username"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
      };
}
