import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:somnio_flutter_challenge/widgets/blog_card.dart';
import 'package:somnio_flutter_challenge/widgets/somnio_network_image.dart';

void main() {
  group('BlogCard', () {
    testWidgets('displays the blog title, description, and chip label',
        (WidgetTester tester) async {
      const blogTitle = 'Test Blog Title';
      const blogDescription = 'Test Blog Description';
      const blogLabel = 'Technology';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BlogCard(
              title: blogTitle,
              description: blogDescription,
              label: blogLabel,
            ),
          ),
        ),
      );

      // Verify that the title, description, and chip label are displayed
      expect(find.text(blogTitle), findsOneWidget);
      expect(find.text(blogDescription), findsOneWidget);
      expect(find.text(blogLabel), findsOneWidget);
    });

    testWidgets('displays the favorite icon correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BlogCard(
              title: 'Test Blog',
              description: 'Test Description',
              isFavorite: true, // Test with blog marked as favorite
            ),
          ),
        ),
      );

      // Verify that the favorite icon is displayed
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('calls onFavoriteTap when favorite icon is tapped',
        (WidgetTester tester) async {
      var favoriteTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlogCard(
              title: 'Test Blog',
              description: 'Test Description',
              isFavorite: false,
              onFavoriteTap: () {
                favoriteTapped = true;
              },
            ),
          ),
        ),
      );

      // Tap the favorite icon
      await tester.tap(find.byIcon(Icons.favorite_border_outlined));
      await tester.pump();

      // Verify that the onFavoriteTap callback was called
      expect(favoriteTapped, isTrue);
    });

    testWidgets('displays the "Read more" link and calls onTap when tapped',
        (WidgetTester tester) async {
      var readMoreTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlogCard(
              title: 'Test Blog',
              description: 'Test Description',
              onTap: () {
                readMoreTapped = true;
              },
            ),
          ),
        ),
      );

      // Verify that the "Read more" link is displayed
      expect(find.text('Read more'), findsOneWidget);

      // Tap the "Read more" link
      await tester.tap(find.text('Read more'));
      await tester.pump();

      // Verify that the onTap callback was called
      expect(readMoreTapped, isTrue);
    });

    testWidgets('displays the image from SomnioNetworkImage',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BlogCard(
              title: 'Test Blog',
              description: 'Test Description',
              imageUrl: 'https://example.com/image.jpg',
            ),
          ),
        ),
      );

      // Verify that the SomnioNetworkImage widget is used
      expect(find.byType(SomnioNetworkImage), findsOneWidget);
    });
  });
}
