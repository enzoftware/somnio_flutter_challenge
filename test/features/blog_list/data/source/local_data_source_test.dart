import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/core/local/storage.dart';
import 'package:somnio_flutter_challenge/features/blog_list/data/data.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late MockStorage mockStorage;
  late BlogListLocalDataSource localDataSource;

  const testBlog = Blog(
    id: 1,
    title: 'Test Blog',
    body: 'Test Body',
    isFavorite: true,
  );

  final testBlogJson = jsonEncode(testBlog.toJson());
  final testBlogsStringList = [testBlogJson];

  setUp(() {
    mockStorage = MockStorage();
    localDataSource = BlogListLocalDataSource(storage: mockStorage);
  });

  group('BlogListLocalDataSource', () {
    const key = 'blogs';

    group('fetchFavoriteBlogs', () {
      test('returns list of favorite blogs from storage', () async {
        when(() => mockStorage.getListString(key))
            .thenAnswer((_) async => testBlogsStringList);

        final blogs = await localDataSource.fetchFavoriteBlogs();

        expect(blogs, [testBlog]);
        verify(() => mockStorage.getListString(key)).called(1);
      });

      test('returns empty list when no blogs are stored', () async {
        when(() => mockStorage.getListString(key)).thenAnswer((_) async => []);

        final blogs = await localDataSource.fetchFavoriteBlogs();

        expect(blogs, isEmpty);
        verify(() => mockStorage.getListString(key)).called(1);
      });
    });

    group('removeFavoriteBlog', () {
      test('removes a blog from favorites by id', () async {
        when(() => mockStorage.getListString(key))
            .thenAnswer((_) async => testBlogsStringList);
        when(() => mockStorage.writeListString(key, any()))
            .thenAnswer((_) async => {});

        await localDataSource.removeFavoriteBlog(1);

        verify(() => mockStorage.getListString(key)).called(1);
        verify(() => mockStorage.writeListString(key, [])).called(1);
      });
    });

    group('saveFavoriteBlog', () {
      test('saves a blog to favorites', () async {
        when(() => mockStorage.getListString(key)).thenAnswer((_) async => []);
        when(() => mockStorage.writeListString(key, any()))
            .thenAnswer((_) async => {});

        await localDataSource.saveFavoriteBlog(testBlog);

        final expectedJsonList = [testBlogJson];
        verify(() => mockStorage.getListString(key)).called(1);
        verify(() => mockStorage.writeListString(key, expectedJsonList))
            .called(1);
      });
    });

    group('isFavoriteBlog', () {
      test('returns true if the blog is in favorites', () async {
        when(() => mockStorage.getListString(key))
            .thenAnswer((_) async => testBlogsStringList);

        final result = await localDataSource.isFavoriteBlog(1);

        expect(result, true);
        verify(() => mockStorage.getListString(key)).called(1);
      });

      test('returns false if the blog is not in favorites', () async {
        when(() => mockStorage.getListString(key)).thenAnswer((_) async => []);

        final result = await localDataSource.isFavoriteBlog(1);

        expect(result, false);
        verify(() => mockStorage.getListString(key)).called(1);
      });
    });
  });
}
