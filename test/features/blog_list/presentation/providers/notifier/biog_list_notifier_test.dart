import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/presentation/providers/blog_list_provider.dart';
import 'package:somnio_flutter_challenge/features/blog_list/presentation/providers/notifier/biog_list_notifier.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/use_case/fetch_blogs_use_case.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/use_case/toggle_favorite_blog_use_case.dart';

class MockFetchBlogsUseCase extends Mock implements FetchBlogsUseCase {}

class MockToggleFavoriteBlogUseCase extends Mock
    implements ToggleFavoriteBlogUseCase {}

void main() {
  late ProviderContainer container;
  late MockFetchBlogsUseCase mockFetchBlogsUseCase;
  late MockToggleFavoriteBlogUseCase mockToggleFavoriteBlogUseCase;

  final testBlogs = [
    const Blog(id: 1, title: 'Blog 1', body: 'Body 1', isFavorite: false),
    const Blog(id: 2, title: 'Blog 2', body: 'Body 2', isFavorite: false),
  ];

  final newBlogs = [
    const Blog(id: 3, title: 'Blog 3', body: 'Body 3', isFavorite: false),
  ];

  setUp(() {
    mockFetchBlogsUseCase = MockFetchBlogsUseCase();
    mockToggleFavoriteBlogUseCase = MockToggleFavoriteBlogUseCase();

    container = ProviderContainer(
      overrides: [
        blogListUseCaseProvider.overrideWithValue(mockFetchBlogsUseCase),
        toggleFavoriteBlogUseCaseProvider
            .overrideWithValue(mockToggleFavoriteBlogUseCase),
      ],
    );

    registerFallbackValue(testBlogs.first);
  });

  tearDown(() {
    container.dispose();
  });

  group('BlogListNotifier Tests', () {
    test('Initial load of blogs', () async {
      when(() => mockFetchBlogsUseCase.execute())
          .thenAnswer((_) async => testBlogs);

      final notifier = container.read(blogListNotifierProvider.notifier);
      final result = await notifier.build();

      expect(result, testBlogs);
      expect(notifier.state, AsyncData(testBlogs));
    });

    test('Load more blogs appends to existing list', () async {
      when(() => mockFetchBlogsUseCase.execute())
          .thenAnswer((_) async => testBlogs);

      final notifier = container.read(blogListNotifierProvider.notifier);
      await notifier.build();
      when(() => mockFetchBlogsUseCase.execute())
          .thenAnswer((_) async => newBlogs);
      await notifier.loadMoreBlogs();

      expect(
        notifier.state.value,
        [...testBlogs, ...newBlogs],
      );
    });

    test('Toggle favorite blog updates state', () async {
      final blogToToggle = testBlogs.first.copyWith(isFavorite: false);
      final updatedBlog = blogToToggle.copyWith(isFavorite: true);

      when(() => mockFetchBlogsUseCase.execute())
          .thenAnswer((_) async => testBlogs);
      when(() =>
              mockToggleFavoriteBlogUseCase.execute(blog: any(named: 'blog')))
          .thenAnswer((_) async => {});

      final notifier = container.read(blogListNotifierProvider.notifier);
      await notifier.build();
      await notifier.toggleFavoriteBlog(blogToToggle);

      final expectedBlogs = [updatedBlog, testBlogs[1]];

      expect(notifier.state.value, expectedBlogs);
      verify(() =>
              mockToggleFavoriteBlogUseCase.execute(blog: any(named: 'blog')))
          .called(1);
    });

    test('Prevents multiple loadMoreBlogs requests at the same time', () async {
      when(() => mockFetchBlogsUseCase.execute())
          .thenAnswer((_) async => testBlogs);

      final notifier = container.read(blogListNotifierProvider.notifier);
      await notifier.build();

      notifier.loadMoreBlogs();

      verify(() => mockFetchBlogsUseCase.execute()).called(3);
    });
  });
}
