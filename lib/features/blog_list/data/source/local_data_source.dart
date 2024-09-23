import 'dart:async';
import 'dart:convert';

import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/core/local/storage.dart';

/// {@template blog_list_local_data_source}
/// A data source for managing the favorite blogs stored locally.
/// It interacts with a [Storage] interface for persistent storage operations.
/// {@endtemplate}
class BlogListLocalDataSource {
  /// {@macro blog_list_local_data_source}
  BlogListLocalDataSource({required Storage storage}) : _storage = storage;

  /// The underlying [Storage] interface for saving and retrieving data.
  final Storage _storage;

  static const key = 'blogs';

  /// Fetches the list of favorite blogs from the local storage.
  ///
  /// Returns a list of [Blog] instances that were marked as favorites.
  Future<List<Blog>> fetchFavoriteBlogs() async {
    final data = await _storage.getListString(key);
    return data.map((e) => Blog.fromJson(jsonDecode(e))).toList();
  }

  /// Removes a blog from the list of favorites based on its [id].
  Future<void> removeFavoriteBlog(int id) async {
    final data = await fetchFavoriteBlogs();
    final newData = List<Blog>.from(data)..removeWhere((e) => e.id == id);
    final listString = newData.map((e) => jsonEncode(e.toJson())).toList();
    await _storage.writeListString(key, listString);
  }

  /// Saves a [blog] to the list of favorite blogs in local storage.
  Future<void> saveFavoriteBlog(Blog blog) async {
    final data = await _storage.getListString(key);
    final newFavorites = List<String>.from(data)
      ..add(
        jsonEncode(blog.toJson()),
      );
    await _storage.writeListString(key, newFavorites);
  }

  /// Checks whether a blog with a given [id] is marked as favorite.
  Future<bool> isFavoriteBlog(int id) async {
    final data = await _storage.getListString(key);
    final blogs = data.map((e) => Blog.fromJson(jsonDecode(e))).toList();
    return blogs.any((e) => e.id == id);
  }
}
