import 'package:court_booker_app/app/extensions/book_model_list_extension.dart';
import 'package:court_booker_app/blocs/book/book_bloc.dart';
import 'package:court_booker_app/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BookingsList extends StatelessWidget {
  const BookingsList({
    super.key,
    required this.bookings,
  });

  final List<BookModel> bookings;

  @override
  Widget build(BuildContext context) {
    final upcomingBookings = bookings.upcomingBookings();

    return ListView.builder(
      itemCount: upcomingBookings.length,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) {
        final book = upcomingBookings[index];
        return ListTile(
          title: Text('Court ${book.court.name}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_2_outlined,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    book.username,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy-HH:mm').format(book.dateTime),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.water_drop_outlined,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    'Precipitation probability: ${book.rainfallPercentage.toInt()}%',
                  ),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () async {
              final result = await showDialog<bool?>(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: const Text(
                          'Are you sure you want to delete this reservation?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pop(true);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  ) ??
                  false;

              if (result && context.mounted) {
                context.read<BookBloc>().add(UnbookCourt(book.id));
              }
            },
            icon: const Icon(
              Icons.delete_rounded,
            ),
          ),
        );
      },
    );
  }
}
