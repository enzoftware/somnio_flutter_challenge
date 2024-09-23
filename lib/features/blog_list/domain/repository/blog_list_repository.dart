import 'package:somnio_flutter_challenge/core/core.dart';

abstract class BlogListRepository {
  Future<List<Blog>> fetchBlogNews();
  Future<void> saveFavoriteBlog(Blog blog);
  Future<void> removeFavoriteBlog(int id);
  Future<bool> isFavoriteBlog(int id);
}
