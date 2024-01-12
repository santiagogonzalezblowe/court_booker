import 'package:court_booker_app/models/book_model.dart';
import 'package:court_booker_app/models/court_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:uuid/uuid.dart';

part 'book_event.dart';

class BookBloc extends HydratedBloc<BookEvent, List<BookModel>> {
  BookBloc() : super([]) {
    on<BookCourt>(_onBookCourt);
    on<UnbookCourt>(_onUnbookCourt);
  }

  final _uuid = const Uuid();

  void _onBookCourt(BookCourt event, Emitter<List<BookModel>> emit) {
    final newList = List<BookModel>.from(state)
      ..add(
        BookModel(
          id: _uuid.v4(),
          court: event.court,
          username: event.username,
          dateTime: event.dateTime,
          rainfallPercentage: event.rainfallPercentage,
        ),
      );
    _sortListByDateTime(newList);
    emit(newList);
  }

  void _onUnbookCourt(UnbookCourt event, Emitter<List<BookModel>> emit) {
    final updatedList = state.where((book) => book.id != event.id).toList();
    _sortListByDateTime(updatedList);
    emit(updatedList);
  }

  void _sortListByDateTime(List<BookModel> list) {
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  List<BookModel>? fromJson(Map<String, dynamic> json) {
    var booksJson = json['books'] as List;
    return booksJson.map((bookJson) => BookModel.fromJson(bookJson)).toList();
  }

  @override
  Map<String, dynamic>? toJson(List<BookModel> state) {
    return {
      'books': state.map((book) => book.toJson()).toList(),
    };
  }
}
