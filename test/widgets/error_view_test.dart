import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:somnio_flutter_challenge/widgets/error_view.dart';

void main() {
  group('ErrorView', () {
    testWidgets('displays the provided error message',
        (WidgetTester tester) async {
      const errorMessage = 'Something went wrong';

      await tester.pumpWidget(
        const MaterialApp(
          home: ErrorView(message: errorMessage),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('displays the error message in the center',
        (WidgetTester tester) async {
      const errorMessage = 'An error occurred';

      await tester.pumpWidget(
        const MaterialApp(
          home: ErrorView(message: errorMessage),
        ),
      );

      final centerFinder = find.byType(Center);
      final textFinder = find.text(errorMessage);

      expect(centerFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);

      final Center centerWidget = tester.widget(centerFinder);
      final Text textWidget = tester.widget(textFinder);

      expect(centerWidget.child, equals(textWidget));
    });

    testWidgets('displays the error message with red color',
        (WidgetTester tester) async {
      const errorMessage = 'Failed to load';

      await tester.pumpWidget(
        const MaterialApp(
          home: ErrorView(message: errorMessage),
        ),
      );

      final textFinder = find.text(errorMessage);
      final Text textWidget = tester.widget(textFinder);

      expect(textWidget.style?.color, equals(Colors.red));
    });
  });
}
