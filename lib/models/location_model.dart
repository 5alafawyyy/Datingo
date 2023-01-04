// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String placeId;
  final String name;
  final double lat;
  final double lon;

  const Location({
    this.placeId = '',
    this.name = '',
    required this.lat,
    required this.lon,
  });
  static const initialLocation = Location(lat: 0, lon: 0);

  Location copyWith({
    String? placeId,
    String? name,
    double? lat,
    double? lon,
  }) {
    return Location(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  @override
  List<Object> get props => [placeId, name, lat, lon];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'placeId': placeId,
      'name': name,
      'lat': lat,
      'lon': lon,
    };
  }

  factory Location.fromSnapshot(Map<String, dynamic> json) {
    return Location(
      placeId: json['placeId'],
      name: json['name'],
      lat: json['geometry']['location']['lat'],
      lon: json['geometry']['location']['lon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromSnapshot(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
