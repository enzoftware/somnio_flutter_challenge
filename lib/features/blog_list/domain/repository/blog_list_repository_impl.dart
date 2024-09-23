import 'dart:async';

import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/data/data.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/repository/blog_list_repository.dart';

/// {@template blog_list_repository_impl}
/// A concrete implementation of the [BlogListRepository] that interacts with
/// both remote and local data sources to manage blog data.
///
/// It fetches blog posts from a remote API and manages favorite blogs locally.
/// {@endtemplate}
class BlogListRepositoryImpl extends BlogListRepository {
  /// {@macro blog_list_repository_impl}
  BlogListRepositoryImpl({
    required BlogListRemoteDataSource remoteDataSource,
    required BlogListLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final BlogListRemoteDataSource _remoteDataSource;
  final BlogListLocalDataSource _localDataSource;

  /// Fetches blog news from the remote source and updates each blog with its favorite status.
  ///
  /// Returns a list of updated [Blog] instances.
  ///
  /// Throws a [Exception] if an error occurs during fetching.
  @override
  Future<List<Blog>> fetchBlogNews() async {
    try {
      final blogs = await _remoteDataSource.fetchBlogNews();

      final updatedBlogs = await Future.wait(blogs.map((b) async {
        final isFavorite = await isFavoriteBlog(b.id ?? -1);
        return b.copyWith(isFavorite: isFavorite);
      }).toList());

      return updatedBlogs;
    } catch (e) {
      throw Exception();
    }
  }

  /// Checks if a blog is marked as favorite by its [id].
  @override
  Future<bool> isFavoriteBlog(int id) {
    return _localDataSource.isFavoriteBlog(id);
  }

  /// Removes a blog from favorites based on its [id].
  @override
  Future<void> removeFavoriteBlog(int id) async {
    unawaited(_localDataSource.removeFavoriteBlog(id));
  }

  /// Saves a blog to favorites.
  @override
  Future<void> saveFavoriteBlog(Blog blog) async {
    unawaited(_localDataSource.saveFavoriteBlog(blog));
  }
}
