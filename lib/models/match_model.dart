import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:datingo/models/models.dart';

class Match extends Equatable {
  final String userId;
  final User matchedUser;
  final List<Chat>? chat;

  const Match({
    required this.userId,
    required this.matchedUser,
    this.chat,
  });

  Match copyWith({
    String? userId,
    User? matchedUser,
    List<Chat>? chat,
  }) {
    return Match(
      userId: userId ?? this.userId,
      matchedUser: matchedUser ?? this.matchedUser,
      chat: chat ?? this.chat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'matchedUser': matchedUser.toMap(),
      'chat': chat?.map((x) => x.toMap()).toList(),
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      userId: map['userId'] as String,
      matchedUser: User.fromMap(map['matchedUser'] as Map<String, dynamic>),
      chat: map['chat'] != null
          ? List<Chat>.from(
              (map['chat'] as List<int>).map<Chat?>(
                (x) => Chat.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Match.fromJson(String source) =>
      Match.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        userId,
        matchedUser,
        chat,
      ];

  static Match fromSnapshot(DocumentSnapshot snap, String userId) {
    Match match = Match(
      userId: userId,
      matchedUser: User.fromSnapshot(snap),
    );
    return match;
  }
// 
  // static List<Match> matches = [
  //   Match(
  //     userId: '1',
  //     matchedUser: User.users[1],
  //     // chat: Chat.chats
  //     //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
  //     //     .toList(),
  //   ),
  //   Match(
  //     userId: '2',
  //     matchedUser: User.users[2],
  //     // chat: Chat.chats
  //     //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 3)
  //     //     .toList(),
  //   ),
  //   Match(
  //     userId: '3',
  //     matchedUser: User.users[3],
  //     // chat: Chat.chats
  //     //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 4)
  //     //     .toList(),
  //   ),
  //   Match(
  //     userId: '4',
  //     matchedUser: User.users[4],
  //     // chat: Chat.chats
  //     //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 5)
  //     //     .toList(),
  //   ),
  //   Match(
  //     userId: '5',
  //     matchedUser: User.users[5],
  //     // chat: Chat.chats
  //     //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 6)
  //     //     .toList(),
  //   ),
  //   Match(
  //     userId: '6',
  //     matchedUser: User.users[6],
  //     // chat: Chat.chats
  //     //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 7)
  //     //     .toList(),
  //   ),
  //   Match(
  //     userId: '7',
  //     matchedUser: User.users[7],
  //     // chat: Chat.chats
  //     //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 8)
  //     //     .toList(),
  //   ),
  //   Match(
  //     userId: '8',
  //     matchedUser: User.users[8],
  //     // chat: Chat.chats
  //     //     .where((chat) => chat.userId == 1 && chat.matchedUserId == 9)
  //     //     .toList(),
  //   ),
  // ];


}
