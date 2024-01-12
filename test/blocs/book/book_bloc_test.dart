import 'package:bloc_test/bloc_test.dart';
import 'package:court_booker_app/blocs/book/book_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:court_booker_app/models/book_model.dart';

import '../../helpers/hydrated_bloc.dart';
import '../../models/court_model.mocks.dart';

void main() {
  initHydratedStorage();
  group('BookBloc', () {
    late BookBloc bookBloc;
    late MockCourtModel mockCourtModel;

    setUp(() async {
      bookBloc = BookBloc();
      mockCourtModel = MockCourtModel();
    });

    tearDown(() async {
      bookBloc.close();
    });

    blocTest<BookBloc, List<BookModel>>(
      'emits updated list when BookCourt is added',
      build: () => bookBloc,
      act: (bloc) => bloc.add(BookCourt(
        court: mockCourtModel,
        username: 'testuser',
        dateTime: DateTime(2021, 1, 1),
        rainfallPercentage: 10,
      )),
      expect: () => [
        predicate<List<BookModel>>((state) {
          if (state.length != 1) return false;

          final book = state.first;
          return book.court == mockCourtModel &&
              book.username == 'testuser' &&
              book.dateTime == DateTime(2021, 1, 1) &&
              book.rainfallPercentage == 10;
        })
      ],
    );

    blocTest<BookBloc, List<BookModel>>(
      'emits updated list when UnbookCourt is added',
      build: () => bookBloc,
      seed: () => [
        BookModel(
          id: 'test-id',
          court: mockCourtModel,
          username: 'user',
          dateTime: DateTime.now(),
          rainfallPercentage: 10,
        )
      ],
      act: (bloc) => bloc.add(UnbookCourt('test-id')),
      expect: () => [[]],
    );
  });
}
