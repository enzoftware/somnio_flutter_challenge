import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/presentation/providers/notifier/biog_list_notifier.dart';
import 'package:somnio_flutter_challenge/widgets/widgets.dart';

class BlogListView extends HookConsumerWidget {
  const BlogListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blogs = ref.watch(blogListNotifierProvider);

    return blogs.when(
      data: (blogs) => BlogListDataView(
        blogs: blogs,
      ),
      error: (error, stackTrace) => ErrorView(message: error.toString()),
      loading: () => const LoadingView(),
    );
  }
}

class BlogListDataView extends HookConsumerWidget {
  const BlogListDataView({
    super.key,
    required this.blogs,
  });

  final List<Blog> blogs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = PrimaryScrollController.of(context);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          ref.read(blogListNotifierProvider.notifier).loadMoreBlogs();
        }
      });
      return null;
    }, [scrollController]);

    return ListView.builder(
      controller: scrollController,
      itemCount: blogs.length + 1,
      itemBuilder: (context, index) {
        if (index == blogs.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final blog = blogs[index];
        return BlogCard(
          title: blog.title ?? '',
          description: blog.body ?? '',
          isFavorite: blog.isFavorite,
          onFavoriteTap: () {
            ref
                .read(blogListNotifierProvider.notifier)
                .toggleFavoriteBlog(blog);
          },
        );
      },
    );
  }
}
