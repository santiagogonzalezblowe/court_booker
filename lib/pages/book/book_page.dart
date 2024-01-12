import 'package:court_booker_app/app/constants/courts.dart';
import 'package:court_booker_app/app/extensions/weather_model_extension.dart';
import 'package:court_booker_app/blocs/book/book_bloc.dart';
import 'package:court_booker_app/blocs/weather/weather_bloc.dart';
import 'package:court_booker_app/models/book_model.dart';
import 'package:court_booker_app/models/court_model.dart';
import 'package:court_booker_app/repositories/weather_repository.dart';
import 'package:court_booker_app/widgets/book/book_button.dart';
import 'package:court_booker_app/widgets/book/date_time_pickers.dart';
import 'package:court_booker_app/widgets/book/precipitation_probability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookPage extends StatelessWidget {
  const BookPage({
    super.key,
    required this.bookings,
  });

  final List<BookModel> bookings;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(context.read<WeatherRepository>()),
      child: BookView(
        bookings: bookings,
      ),
    );
  }
}

class BookView extends StatefulWidget {
  const BookView({
    super.key,
    required this.bookings,
  });

  final List<BookModel> bookings;

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final usernameController = TextEditingController();

  CourtModel? selectedCourt;
  DateTime? date;
  TimeOfDay? time;

  @override
  void initState() {
    usernameController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Something went wrong in obtaining the precipitation.',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Booking',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButtonFormField<CourtModel>(
                  value: selectedCourt,
                  hint: const Text('Court'),
                  items: courts
                      .map(
                        (e) => DropdownMenuItem<CourtModel>(
                          value: e,
                          child: Text('Court ${e.name}'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCourt = value;
                    });
                    _featchWeather();
                  },
                ),
              ),
              const SizedBox(height: 20),
              DateTimePickers(
                time: time,
                date: date,
                selectedCourt: selectedCourt,
                bookings: widget.bookings,
                onSelectedDate: (newDate) {
                  setState(() {
                    date = newDate;
                    time = null;
                  });
                  _featchWeather();
                },
                onSelectedTime: (newTime) {
                  setState(() {
                    time = newTime;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: PrecipitationProbability(time: time),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: BookButton(
                  onPressed: isButtonValid() ? _onButtonPressed : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isButtonValid() {
    return selectedCourt != null &&
        usernameController.text.isNotEmpty &&
        date != null &&
        time != null;
  }

  void _onButtonPressed() {
    final weatherState = context.read<WeatherBloc>().state;
    late int rainfallPercentage;
    if (weatherState is WeatherSuccess) {
      rainfallPercentage =
          weatherState.weather.getNearestPrecipitationProbability(
        time!,
      );
    } else {
      rainfallPercentage = 0;
    }
    context.read<BookBloc>().add(
          BookCourt(
            court: selectedCourt!,
            username: usernameController.text,
            dateTime: DateTime(
              date!.year,
              date!.month,
              date!.day,
              time!.hour,
              time!.minute,
            ),
            rainfallPercentage: rainfallPercentage,
          ),
        );

    context.pop();
  }

  void _featchWeather() {
    if (selectedCourt != null && date != null) {
      context.read<WeatherBloc>().add(
            FetchWeather(
              latLng: selectedCourt!.latLng,
              date: date!,
            ),
          );
    }
  }
}
