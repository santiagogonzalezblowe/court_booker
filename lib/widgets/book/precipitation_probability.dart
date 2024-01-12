import 'package:court_booker_app/app/extensions/weather_model_extension.dart';
import 'package:court_booker_app/blocs/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrecipitationProbability extends StatelessWidget {
  const PrecipitationProbability({
    super.key,
    required this.time,
  });

  final TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    if (time == null) return const SizedBox.shrink();
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSuccess) {
          return Row(
            children: [
              Icon(
                Icons.water_drop_outlined,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                'Precipitation probability: ${state.weather.getNearestPrecipitationProbability(time!)}%',
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
