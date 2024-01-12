import 'package:court_booker_app/app/routes/routers/book_router.dart';
import 'package:court_booker_app/models/book_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeEmpty extends StatelessWidget {
  const HomeEmpty(
    this.bookings, {
    super.key,
  });

  final List<BookModel> bookings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: ListView(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'It seems that you do not have any reservations.',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '\nClick on this text to reserve a tennis court.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.go(
                          '/book',
                          extra: BookRouter(bookings),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
