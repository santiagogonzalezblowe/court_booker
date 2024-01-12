import 'package:court_booker_app/models/book_model.dart';

extension BookModelListExtension on List<BookModel> {
  List<BookModel> upcomingBookings() {
    return where((book) => book.dateTime.isAfter(DateTime.now())).toList();
  }
}
