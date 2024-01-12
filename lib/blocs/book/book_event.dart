part of 'book_bloc.dart';

@immutable
sealed class BookEvent {}

class BookCourt extends BookEvent {
  BookCourt({
    required this.court,
    required this.username,
    required this.dateTime,
    required this.rainfallPercentage,
  });

  final CourtModel court;
  final String username;
  final DateTime dateTime;
  final int rainfallPercentage;
}

class UnbookCourt extends BookEvent {
  UnbookCourt(this.id);

  final String id;
}
