import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:court_booker_app/blocs/weather/weather_bloc.dart';
import 'package:court_booker_app/models/lat_lng_model.dart';
import 'package:court_booker_app/models/weather_model.dart';

import '../../models/weather_model.mocks.dart';
import '../../repositories/weather_repository_test.mocks.dart';

void main() {
  group('WeatherBloc', () {
    late MockWeatherRepository mockWeatherRepository;
    late WeatherBloc weatherBloc;
    late LatLngModel mockLatLng;
    late WeatherModel mockWeather;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      weatherBloc = WeatherBloc(mockWeatherRepository);
      mockLatLng = const LatLngModel(10, 10);
      mockWeather = MockWeatherModel();
    });

    tearDown(() {
      weatherBloc.close();
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherSuccess] when FetchWeather is added and getWeather is successful',
      build: () => weatherBloc,
      act: (bloc) {
        when(mockWeatherRepository.getWeather(
          dateTime: anyNamed('dateTime'),
          latLng: anyNamed('latLng'),
        )).thenAnswer((_) async => mockWeather);
        bloc.add(FetchWeather(date: DateTime.now(), latLng: mockLatLng));
      },
      expect: () => [
        WeatherLoading(),
        WeatherSuccess(mockWeather),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherFailure] when FetchWeather is added and getWeather throws Exception',
      build: () => weatherBloc,
      act: (bloc) {
        when(mockWeatherRepository.getWeather(
          dateTime: anyNamed('dateTime'),
          latLng: anyNamed('latLng'),
        )).thenThrow(Exception());
        bloc.add(FetchWeather(date: DateTime.now(), latLng: mockLatLng));
      },
      expect: () => [
        WeatherLoading(),
        WeatherFailure(),
      ],
    );
  });
}
