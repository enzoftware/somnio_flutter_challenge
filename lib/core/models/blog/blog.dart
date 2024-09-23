import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog.g.dart';

/// {@template blog}
/// A data class that represents a blog post.
///
/// Includes fields such as:
/// - [id]: the unique identifier for the blog
/// - [title]: the title of the blog post
/// - [body]: the content of the blog post
/// - [isFavorite]: indicates whether the blog is marked as favorite
/// {@endtemplate}
@JsonSerializable()
class Blog extends Equatable {
  /// {@macro blog}
  const Blog({
    required this.id,
    required this.title,
    required this.body,
    this.isFavorite = false,
  });

  /// Whether the blog is marked as favorite.
  final bool isFavorite;

  /// Unique identifier for the blog post.
  final int? id;

  /// Title of the blog post.
  final String? title;

  /// Content of the blog post.
  final String? body;

  /// Creates a new [Blog] instance from a JSON map.
  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);

  /// Converts the [Blog] instance into a JSON map.
  Map<String, dynamic> toJson() => _$BlogToJson(this);

  /// Creates a copy of the current [Blog] with new values.
  ///
  /// If a field is not provided, the current value is retained.
  Blog copyWith({
    bool? isFavorite,
    int? id,
    String? title,
    String? body,
  }) {
    return Blog(
      isFavorite: isFavorite ?? this.isFavorite,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  String toString() {
    return "$isFavorite, $id, $title, $body, ";
  }

  @override
  List<Object?> get props => [
        isFavorite,
        id,
        title,
        body,
      ];
}
