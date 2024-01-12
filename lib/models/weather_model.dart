class WeatherModel {
  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final Hourly hourly;

  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.hourly,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        hourly: Hourly.fromJson(json["hourly"]),
      );
}

class Hourly {
  final List<DateTime> time;
  final List<int> precipitationProbability;

  Hourly({
    required this.time,
    required this.precipitationProbability,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        time: List<DateTime>.from(
          json["time"].map(
            (x) => DateTime.parse(x as String),
          ),
        ),
        precipitationProbability: List<int>.from(
          json["precipitation_probability"].map((x) => x),
        ),
      );
}
