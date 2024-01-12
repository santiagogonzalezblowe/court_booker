import 'package:court_booker_app/app/routes/routers/book_router.dart';
import 'package:court_booker_app/blocs/book/book_bloc.dart';
import 'package:court_booker_app/models/book_model.dart';
import 'package:court_booker_app/widgets/home/bookings_list.dart';
import 'package:court_booker_app/widgets/home/home_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, List<BookModel>>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Court Booker',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.sports_tennis,
                )
              ],
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go(
                '/book',
                extra: BookRouter(state),
              );
            },
            child: const Icon(Icons.book),
          ),
          body: Builder(
            builder: (context) {
              if (state.isEmpty) {
                return HomeEmpty(state);
              }
              return BookingsList(
                bookings: state,
              );
            },
          ),
        );
      },
    );
  }
}
