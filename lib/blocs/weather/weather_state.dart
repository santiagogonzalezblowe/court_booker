part of 'weather_bloc.dart';

@immutable
class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weather;

  WeatherSuccess(this.weather);
}

final class WeatherFailure extends WeatherState {}
