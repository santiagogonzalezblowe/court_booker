class LatLngModel {
  const LatLngModel(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  factory LatLngModel.fromJson(Map<String, dynamic> json) => LatLngModel(
        json['latitude'] as double,
        json['longitude'] as double,
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
