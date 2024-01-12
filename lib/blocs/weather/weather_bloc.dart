import 'package:bloc/bloc.dart';
import 'package:court_booker_app/models/lat_lng_model.dart';
import 'package:court_booker_app/models/weather_model.dart';
import 'package:court_booker_app/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._weatherRepository) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  final WeatherRepository _weatherRepository;

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    try {
      final weather = await _weatherRepository.getWeather(
        dateTime: event.date,
        latLng: event.latLng,
      );

      emit(WeatherSuccess(weather));
    } on Exception {
      emit(WeatherFailure());
    }
  }
}
