import 'package:court_booker_app/app/extensions/date_time_extension.dart';
import 'package:court_booker_app/models/book_model.dart';
import 'package:court_booker_app/models/court_model.dart';
import 'package:court_booker_app/widgets/book/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickers extends StatelessWidget {
  const DateTimePickers({
    super.key,
    required this.time,
    required this.date,
    required this.selectedCourt,
    required this.onSelectedTime,
    required this.onSelectedDate,
    required this.bookings,
  });

  final TimeOfDay? time;
  final DateTime? date;
  final CourtModel? selectedCourt;
  final Function(TimeOfDay newTime) onSelectedTime;
  final Function(DateTime newDate) onSelectedDate;
  final List<BookModel> bookings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            onTap: () async {
              final now = DateTime.now();

              DateTime? newDate = await showDatePicker(
                context: context,
                firstDate: DateTime(now.year, now.month, now.day),
                lastDate: DateTime(now.year, now.month, now.day + 9),
                initialDate: date ?? DateTime.now(),
              );

              if (newDate != null) {
                onSelectedDate.call(newDate);
              }
            },
            readOnly: true,
            controller: TextEditingController(
              text: date != null ? DateFormat('dd/MM/yyyy').format(date!) : '',
            ),
            decoration: const InputDecoration(
              hintText: 'Date',
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (date != null)
          TimePicker(
            isToday: DateTime.now().isSameDate(date!),
            time: time,
            date: date!,
            onSelectedTime: onSelectedTime,
            selectedCourt: selectedCourt,
            bookings: bookings,
          ),
      ],
    );
  }
}
