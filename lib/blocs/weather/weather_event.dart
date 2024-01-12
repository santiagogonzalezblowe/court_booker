part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final LatLngModel latLng;
  final DateTime date;

  FetchWeather({
    required this.latLng,
    required this.date,
  });
}
