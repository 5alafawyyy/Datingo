// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime dateTime;
  final String timeString;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeString,
  });

  Message copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    String? message,
    DateTime? dateTime,
    String? timeString,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      dateTime: dateTime ?? this.dateTime,
      timeString: timeString ?? this.timeString,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'timeString': timeString,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      senderId: map['senderId'] as int,
      receiverId: map['receiverId'] as int,
      message: map['message'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      timeString: map['timeString'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      senderId,
      receiverId,
      message,
      dateTime,
      timeString,
    ];
  }

  static List<Message> messages = [
    Message(
      id: 1,
      senderId: 1,
      receiverId: 2,
      message: 'Hey, how are you?',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 2,
      senderId: 2,
      receiverId: 1,
      message: 'I\'m good, and you',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 3,
      senderId: 1,
      receiverId: 2,
      message: 'I\'m good, as well. Thank you',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 4,
      senderId: 1,
      receiverId: 3,
      message: 'Hey, how are you?',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 5,
      senderId: 3,
      receiverId: 1,
      message: 'I\'m good, and you',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 6,
      senderId: 1,
      receiverId: 5,
      message: 'Hey, how are you?',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 7,
      senderId: 5,
      receiverId: 1,
      message: 'I\'m good, thank you.',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 8,
      senderId: 1,
      receiverId: 6,
      message: 'Hey, how are you?',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 9,
      senderId: 6,
      receiverId: 1,
      message: 'I\'m good, thank you.',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 10,
      senderId: 1,
      receiverId: 7,
      message: 'Hey, how are you?',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 11,
      senderId: 7,
      receiverId: 1,
      message: 'I\'m good, thank you.',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(DateTime.now()),
    ),
  ];
}
