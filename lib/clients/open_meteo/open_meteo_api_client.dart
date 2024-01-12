import 'dart:convert';

import 'package:court_booker_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

class WeatherParseFailure implements Exception {}

class OpenMeteoApiClient {
  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlWeather = 'api.open-meteo.com';

  final http.Client _httpClient;

  /// Fetches [Weather] for a given [latitude] and [longitude] and [dateTime].
  Future<WeatherModel> getWeather({
    required double latitude,
    required double longitude,
    required DateTime dateTime,
  }) async {
    final weatherRequest = Uri.https(_baseUrlWeather, 'v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'hourly': 'precipitation_probability',
      'timezone': 'auto',
      'start_date': DateFormat('yyyy-MM-dd').format(dateTime),
      'end_date': DateFormat('yyyy-MM-dd').format(dateTime),
    });

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    try {
      return WeatherModel.fromJson(bodyJson);
    } catch (_) {
      throw WeatherParseFailure();
    }
  }
}
