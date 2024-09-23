import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/presentation/providers/blog_list_provider.dart';

part 'biog_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class BlogListNotifier extends _$BlogListNotifier {
  List<Blog> _blogs = [];
  bool _isLoadingMore = false;
  int _currentPage = 1;

  @override
  Future<List<Blog>> build() async {
    _blogs = await _fetchBlogs();
    return _blogs;
  }

  Future<void> loadMoreBlogs() async {
    if (_isLoadingMore) return;

    _isLoadingMore = true;
    _currentPage++;

    final newBlogs = await _fetchBlogs(page: _currentPage);

    final updatedBlogs = List<Blog>.from(_blogs)..addAll(newBlogs);
    _blogs = updatedBlogs;

    _isLoadingMore = false;

    state = AsyncData(_blogs);
  }

  Future<List<Blog>> _fetchBlogs({int page = 1}) async {
    final useCase = ref.read(blogListUseCaseProvider);
    return await useCase.execute();
  }

  Future<void> toggleFavoriteBlog(Blog blog) async {
    final useCase = ref.read(toggleFavoriteBlogUseCaseProvider);
    await useCase.execute(blog: blog);

    final updatedBlog = blog.copyWith(isFavorite: !blog.isFavorite);

    final updatedBlogs =
        _blogs.map((b) => b.id == blog.id ? updatedBlog : b).toList();
    _blogs = updatedBlogs;

    state = AsyncData(_blogs);
  }
}
