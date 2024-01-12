import 'package:court_booker_app/models/book_model.dart';
import 'package:court_booker_app/models/court_model.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
    required this.isToday,
    required this.time,
    required this.selectedCourt,
    required this.onSelectedTime,
    required this.bookings,
    required this.date,
  });

  final bool isToday;
  final TimeOfDay? time;
  final DateTime date;
  final CourtModel? selectedCourt;
  final Function(TimeOfDay newTime) onSelectedTime;
  final List<BookModel> bookings;

  @override
  Widget build(BuildContext context) {
    final times = getTimes();

    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: times.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final isBooked = isTimeBooked(times[index]);

          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: ChoiceChip(
              label: Text(
                times[index].format(context),
              ),
              selectedColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey[700],
              labelStyle: TextStyle(
                color: isBooked ? Colors.black : Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              selected: times[index] == time,
              disabledColor: Colors.red[400],
              onSelected: isBooked
                  ? null
                  : (value) {
                      onSelectedTime.call(times[index]);
                    },
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }

  List<TimeOfDay> getTimes() {
    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    final allTimes = [
      const TimeOfDay(hour: 8, minute: 0),
      const TimeOfDay(hour: 8, minute: 30),
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 9, minute: 30),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 10, minute: 30),
      const TimeOfDay(hour: 11, minute: 0),
      const TimeOfDay(hour: 11, minute: 30),
      const TimeOfDay(hour: 12, minute: 0),
      const TimeOfDay(hour: 12, minute: 30),
      const TimeOfDay(hour: 13, minute: 0),
      const TimeOfDay(hour: 13, minute: 30),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 14, minute: 30),
      const TimeOfDay(hour: 15, minute: 0),
      const TimeOfDay(hour: 15, minute: 30),
      const TimeOfDay(hour: 16, minute: 0),
      const TimeOfDay(hour: 16, minute: 30),
      const TimeOfDay(hour: 17, minute: 0),
      const TimeOfDay(hour: 17, minute: 30),
      const TimeOfDay(hour: 18, minute: 0),
      const TimeOfDay(hour: 18, minute: 30),
      const TimeOfDay(hour: 19, minute: 0),
      const TimeOfDay(hour: 19, minute: 30),
      const TimeOfDay(hour: 20, minute: 0),
      const TimeOfDay(hour: 20, minute: 30),
      const TimeOfDay(hour: 21, minute: 0),
      const TimeOfDay(hour: 21, minute: 30),
      const TimeOfDay(hour: 22, minute: 0),
      const TimeOfDay(hour: 22, minute: 30),
      const TimeOfDay(hour: 23, minute: 00),
    ];

    return isToday
        ? allTimes
            .where(
              (time) => (time.hour > currentTime.hour ||
                  (time.hour == currentTime.hour &&
                      time.minute > currentTime.minute)),
            )
            .toList()
        : List<TimeOfDay>.from(allTimes);
  }

  bool isTimeBooked(TimeOfDay time) {
    final bookingDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    return bookings.any((booking) {
      if (selectedCourt != null && booking.court.id == selectedCourt!.id) {
        final bookedTime = booking.dateTime;
        return bookedTime.year == bookingDateTime.year &&
            bookedTime.month == bookingDateTime.month &&
            bookedTime.day == bookingDateTime.day &&
            bookedTime.hour == bookingDateTime.hour &&
            bookedTime.minute == bookingDateTime.minute;
      }
      return false;
    });
  }
}
