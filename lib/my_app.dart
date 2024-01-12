import 'package:court_booker_app/app/routes/router.dart';
import 'package:court_booker_app/blocs/book/book_bloc.dart';
import 'package:court_booker_app/repositories/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: WeatherRepository(),
      child: BlocProvider(
        create: (context) => BookBloc(),
        child: MaterialApp.router(
          routerConfig: goRouter,
          builder: (context, child) => child!,
        ),
      ),
    );
  }
}
