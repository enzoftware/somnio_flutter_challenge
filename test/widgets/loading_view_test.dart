import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:somnio_flutter_challenge/widgets/loading_view.dart';

void main() {
  group('LoadingView', () {
    testWidgets('displays a circular progress indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoadingView(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays the progress indicator in the center',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoadingView(),
        ),
      );

      final centerFinder = find.byType(Center);
      final progressIndicatorFinder = find.byType(CircularProgressIndicator);

      expect(centerFinder, findsOneWidget);
      expect(progressIndicatorFinder, findsOneWidget);

      final Center centerWidget = tester.widget(centerFinder);
      final CircularProgressIndicator progressIndicator =
          tester.widget(progressIndicatorFinder);

      expect(centerWidget.child, equals(progressIndicator));
    });
  });
}
