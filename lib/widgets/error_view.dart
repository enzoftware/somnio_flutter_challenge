import 'package:flutter/material.dart';

/// {@template error_view}
/// A simple widget to display an error message in the center of the screen.
///
/// This widget is used to show errors that occur within the app.
/// It takes a [message] parameter to display the error message to the user.
/// {@endtemplate}
class ErrorView extends StatelessWidget {
  /// {@macro error_view}
  const ErrorView({super.key, required this.message});

  /// The error message to display.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
