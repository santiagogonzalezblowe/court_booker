import 'package:court_booker_app/models/court_model.dart';

class BookModel {
  BookModel({
    required this.id,
    required this.username,
    required this.dateTime,
    required this.court,
    required this.rainfallPercentage,
  });

  final String id;
  final String username;
  final DateTime dateTime;
  final CourtModel court;
  final int rainfallPercentage;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['id'] as String,
        username: json['username'] as String,
        dateTime: DateTime.parse(json['dateTime'] as String),
        court: CourtModel.fromJson(json['court']),
        rainfallPercentage: json['rainfallPercentage'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'dateTime': dateTime.toIso8601String(),
        'court': court.toJson(),
        'rainfallPercentage': rainfallPercentage,
      };
}
