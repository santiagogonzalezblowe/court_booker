import 'package:court_booker_app/models/lat_lng_model.dart';

class CourtModel {
  final String id;
  final String name;
  final LatLngModel latLng;

  const CourtModel({
    required this.id,
    required this.name,
    required this.latLng,
  });

  factory CourtModel.fromJson(Map<String, dynamic> json) => CourtModel(
        id: json['id'] as String,
        name: json['name'] as String,
        latLng: LatLngModel.fromJson(json['latLng']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'latLng': latLng.toJson(),
      };
}
