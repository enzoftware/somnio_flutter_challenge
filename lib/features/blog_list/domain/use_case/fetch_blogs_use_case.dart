import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/repository/blog_list_repository.dart';

/// {@template fetch_blogs_use_case}
/// A use case class responsible for fetching blog news from the repository.
///
/// This class encapsulates the logic to fetch the list of blogs by interacting
/// with the [BlogListRepository].
/// {@endtemplate}
class FetchBlogsUseCase {
  /// {@macro fetch_blogs_use_case}
  FetchBlogsUseCase({
    required BlogListRepository repository,
  }) : _repository = repository;

  /// The repository that provides the blog data.
  final BlogListRepository _repository;

  /// Executes the use case to fetch blog news from the repository.
  ///
  /// Returns a list of [Blog] objects.
  Future<List<Blog>> execute() => _repository.fetchBlogNews();
}
