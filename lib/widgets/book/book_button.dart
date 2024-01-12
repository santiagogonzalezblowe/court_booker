import 'package:court_booker_app/blocs/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookButton extends StatelessWidget {
  const BookButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              final disable = state is! WeatherSuccess;
              return FilledButton(
                onPressed: disable ? null : onPressed,
                child: state is WeatherLoading
                    ? const SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Book Court'),
              );
            },
          ),
        ),
      ],
    );
  }
}
