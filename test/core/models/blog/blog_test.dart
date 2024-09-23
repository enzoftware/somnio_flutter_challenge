import 'package:flutter_test/flutter_test.dart';
import 'package:somnio_flutter_challenge/core/core.dart';

void main() {
  group('Blog', () {
    const blog = Blog(
      id: 1,
      title: 'Test Blog',
      body: 'This is a test blog',
      isFavorite: false,
    );

    test('supports value equality', () {
      const anotherBlog = Blog(
        id: 1,
        title: 'Test Blog',
        body: 'This is a test blog',
        isFavorite: false,
      );
      expect(blog, equals(anotherBlog));
    });

    test('toString returns correct format', () {
      expect(
        blog.toString(),
        'false, 1, Test Blog, This is a test blog, ',
      );
    });

    test('can convert to JSON', () {
      final json = blog.toJson();
      expect(json, {
        'isFavorite': false,
        'id': 1,
        'title': 'Test Blog',
        'body': 'This is a test blog',
      });
    });

    test('can create from JSON', () {
      final json = {
        'isFavorite': false,
        'id': 1,
        'title': 'Test Blog',
        'body': 'This is a test blog',
      };
      final blogFromJson = Blog.fromJson(json);
      expect(blogFromJson, equals(blog));
    });

    test('copyWith returns a new instance with updated values', () {
      final updatedBlog = blog.copyWith(isFavorite: true);
      expect(updatedBlog.isFavorite, true);
      expect(updatedBlog.id, blog.id);
      expect(updatedBlog.title, blog.title);
      expect(updatedBlog.body, blog.body);
    });

    test('copyWith retains the old value if not provided', () {
      final updatedBlog = blog.copyWith();
      expect(updatedBlog.isFavorite, blog.isFavorite);
      expect(updatedBlog.id, blog.id);
      expect(updatedBlog.title, blog.title);
      expect(updatedBlog.body, blog.body);
    });
  });
}
