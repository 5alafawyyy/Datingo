// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:datingo/models/models.dart';

class Chat extends Equatable {
  final int id;
  final int userId;
  final int matchedUserId;
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.userId,
    required this.matchedUserId,
    required this.messages,
  });

  Chat copyWith({
    int? id,
    int? userId,
    int? matchedUserId,
    List<Message>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      matchedUserId: matchedUserId ?? this.matchedUserId,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'otherUserId': matchedUserId,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] as int,
      userId: map['userId'] as int,
      matchedUserId: map['otherUserId'] as int,
      messages: List<Message>.from(
        (map['messages'] as List<int>).map<Message>(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, userId, matchedUserId, messages];

  static List<Chat> chats = [
    Chat(
      id: 1,
      userId: 1,
      matchedUserId: 2,
      messages: Message.messages
          .where((message) =>
              (message.senderId == 1 && message.receiverId == 2) ||
              (message.senderId == 2 && message.receiverId == 1))
          .toList(),
    ),
    Chat(
      id: 2,
      userId: 1,
      matchedUserId: 3,
      messages: Message.messages
          .where((message) =>
              (message.senderId == 1 && message.receiverId == 3) ||
              (message.senderId == 3 && message.receiverId == 1))
          .toList(),
    ),
    Chat(
      id: 3,
      userId: 2,
      matchedUserId: 3,
      messages: Message.messages
          .where((message) =>
              (message.senderId == 2 && message.receiverId == 3) ||
              (message.senderId == 3 && message.receiverId == 2))
          .toList(),
    ),
    Chat(
      id: 4,
      userId: 1,
      matchedUserId: 5,
      messages: Message.messages
          .where((message) =>
              (message.senderId == 1 && message.receiverId == 5) ||
              (message.senderId == 5 && message.receiverId == 1))
          .toList(),
    ),
    Chat(
      id: 4,
      userId: 1,
      matchedUserId: 6,
      messages: Message.messages
          .where((message) =>
              (message.senderId == 1 && message.receiverId == 6) ||
              (message.senderId == 6 && message.receiverId == 1))
          .toList(),
    ),
  ];
}
