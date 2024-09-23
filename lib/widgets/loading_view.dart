import 'package:flutter/material.dart';

/// {@template loading_view}
/// A simple widget to display a loading indicator in the center of the screen.
///
/// This widget is used to indicate a loading state within the app.
/// {@endtemplate}
class LoadingView extends StatelessWidget {
  /// {@macro loading_view}
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
