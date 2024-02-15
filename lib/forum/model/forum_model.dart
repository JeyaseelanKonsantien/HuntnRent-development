import 'package:cloud_firestore/cloud_firestore.dart';

class ForumChatRoomModel {
  Timestamp? createdAt;
  String? createdBy;
  String? peerId;
  String? roomId;
  String? postContent;

  ForumChatRoomModel({
    this.createdAt,
    this.createdBy,
    this.peerId,
    this.postContent,
    this.roomId,
  });

  ForumChatRoomModel.fromJson(dynamic json) {

    createdAt = json["created_at"];
    createdBy = json["created_by"];
    peerId = json["peer_id"];
    roomId = json["room_id"];
    postContent = json["postContent"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map["created_at"] = createdAt;
    map["created_by"] = createdBy;
    map["peer_id"] = peerId;
    map["room_id"] = roomId;
    map["postContent"] = postContent;
    return map;
  }
}
class PostMessageModel {
  String? sender;
  String? senderImage;
  String? receiver;
  DateTime? createdAt;
  String? roomId;
  var message;
  bool? isSeen;
  int? type;

  PostMessageModel(
      {this.sender,
      this.senderImage,
      this.receiver,
      this.createdAt,
      this.roomId,
      this.message,
      this.isSeen,
      this.type});
  factory PostMessageModel.fromJson(Map<String, dynamic> json) {
    return PostMessageModel(
      sender: json["sender"],
      type: json["type"],
      receiver: json["receiver"],
      createdAt: json["createdAt"],
      roomId: json["roomId"],
      message: json["message"],
      isSeen: json["isSeen"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender'] = sender;
    data['type'] = type;
    data['receiver'] = receiver;
    data['createdAt'] = createdAt;
    data['roomId'] = roomId;
    data['message'] = message;
    data['isSeen'] = isSeen;
    return data;
  }
}
class PostCommentsModel {
  Timestamp? createdAt;
  String? roomId;
  String? doc_id;
  String? message;
  String? senderId;
  int? type;

  PostCommentsModel(
      {this.createdAt,
        this.roomId,
        this.message,
        this.doc_id,
        this.senderId,
        this.type});

  PostCommentsModel.fromJson(dynamic json) {
    createdAt = json["created_at"];
    doc_id = json["doc_id"];
    roomId = json["room_id"];

    message = json["message"];
    senderId = json["sender_id"];

    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["created_at"] = createdAt;
    map["room_id"] = roomId;
    map["doc_id"] = doc_id;

    map["message"] = message;
    map["sender_id"] = senderId;

    map["type"] = type;
    return map;
  }
}

class ReactionsModel{
  String? userId;
  String? postRoomId;
  String? postReaction;

  ReactionsModel({
    this.userId,
    this.postRoomId,
    this.postReaction,
  });

  ReactionsModel.fromJson(dynamic json) {
    userId = json["user_id"];
    postRoomId = json["post_room_id"];
    postReaction = json["post_reaction"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = userId;
    map["post_room_id"] = postRoomId;
    map["post_reaction"] = postReaction;
    return map;
  }
}


enum Reactions{
  like,
  dislike,
  none,
}
