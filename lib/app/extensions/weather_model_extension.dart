import 'package:court_booker_app/models/weather_model.dart';
import 'package:flutter/material.dart';

extension WeatherModelExtension on WeatherModel {
  int getNearestPrecipitationProbability(TimeOfDay timeOfDay) {
    int nearestIndex = 0;
    int nearestDifference = 1440;

    for (var i = 0; i < hourly.time.length; i++) {
      final hourlyTime = hourly.time[i];
      final difference = _timeDifferenceInMinutes(hourlyTime, timeOfDay);
      if (difference < nearestDifference) {
        nearestDifference = difference;
        nearestIndex = i;
      }
    }

    return hourly.precipitationProbability[nearestIndex];
  }

  int _timeDifferenceInMinutes(DateTime dateTime, TimeOfDay timeOfDay) {
    final timeOfDayDateTime = DateTime(
      2000,
      1,
      1,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final dateTimeAdjusted = DateTime(
      2000,
      1,
      1,
      dateTime.hour,
      dateTime.minute,
    );

    return timeOfDayDateTime.difference(dateTimeAdjusted).inMinutes.abs();
  }
}
