import 'package:court_booker_app/app/routes/routers/book_router.dart';
import 'package:court_booker_app/pages/book/book_page.dart';
import 'package:court_booker_app/pages/home/home_page.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: 'book',
          builder: (context, state) {
            final bookRouter = state.extra as BookRouter;
            return BookPage(
              bookings: bookRouter.bookings,
            );
          },
        ),
      ],
    ),
  ],
);
