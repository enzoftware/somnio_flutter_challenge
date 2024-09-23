import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/repository/blog_list_repository.dart';

/// {@template toggle_favorite_blog_use_case}
/// A use case responsible for toggling the favorite status of a blog.
///
/// This use case checks if the blog is already marked as favorite.
/// If it is, it removes the blog from the favorites, otherwise, it adds the blog to the favorites.
/// {@endtemplate}
class ToggleFavoriteBlogUseCase {
  /// {@macro toggle_favorite_blog_use_case}
  const ToggleFavoriteBlogUseCase({
    required BlogListRepository repository,
  }) : _repository = repository;

  /// The repository that manages the blog data.
  final BlogListRepository _repository;

  /// Executes the use case to toggle the favorite status of a [blog].
  ///
  /// If the blog is already a favorite, it removes it from the favorites.
  /// Otherwise, it adds the blog to the favorites.
  Future<void> execute({required Blog blog}) async {
    final isFavorite = await _repository.isFavoriteBlog(blog.id ?? 0);
    isFavorite
        ? _repository.removeFavoriteBlog(blog.id ?? 0)
        : _repository.saveFavoriteBlog(blog);
  }
}
