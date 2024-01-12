import 'dart:async';

import 'package:court_booker_app/clients/open_meteo/open_meteo_api_client.dart';
import 'package:court_booker_app/models/lat_lng_model.dart';
import 'package:court_booker_app/models/weather_model.dart';

class WeatherRepository {
  WeatherRepository({OpenMeteoApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenMeteoApiClient();

  final OpenMeteoApiClient _weatherApiClient;

  Future<WeatherModel> getWeather({
    required LatLngModel latLng,
    required DateTime dateTime,
  }) {
    return _weatherApiClient.getWeather(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      dateTime: dateTime,
    );
  }
}
