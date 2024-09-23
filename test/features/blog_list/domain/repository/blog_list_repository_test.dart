import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/data/data.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/domain.dart';

class MockBlogListRemoteDataSource extends Mock
    implements BlogListRemoteDataSource {}

class MockBlogListLocalDataSource extends Mock
    implements BlogListLocalDataSource {}

void main() {
  late MockBlogListRemoteDataSource mockRemoteDataSource;
  late MockBlogListLocalDataSource mockLocalDataSource;
  late BlogListRepository blogListRepository;

  const testBlog = Blog(
    id: 1,
    title: 'Test Blog',
    body: 'This is a test blog',
    isFavorite: false,
  );

  setUp(() {
    mockRemoteDataSource = MockBlogListRemoteDataSource();
    mockLocalDataSource = MockBlogListLocalDataSource();
    blogListRepository = BlogListRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('BlogListRepositoryImpl', () {
    group('fetchBlogNews', () {
      test('returns updated list of blogs with favorite status', () async {
        when(() => mockRemoteDataSource.fetchBlogNews())
            .thenAnswer((_) async => [testBlog]);
        when(() => mockLocalDataSource.isFavoriteBlog(any()))
            .thenAnswer((_) async => true);

        final result = await blogListRepository.fetchBlogNews();

        final expectedBlog = testBlog.copyWith(isFavorite: true);
        expect(result, equals([expectedBlog]));

        verify(() => mockRemoteDataSource.fetchBlogNews()).called(1);
        verify(() => mockLocalDataSource.isFavoriteBlog(testBlog.id!))
            .called(1);
      });

      test('throws Exception when fetching blogs fails', () async {
        when(() => mockRemoteDataSource.fetchBlogNews()).thenThrow(Exception());

        expect(() => blogListRepository.fetchBlogNews(),
            throwsA(isA<Exception>()));

        verify(() => mockRemoteDataSource.fetchBlogNews()).called(1);
      });
    });

    group('isFavoriteBlog', () {
      test('returns true if the blog is favorite', () async {
        when(() => mockLocalDataSource.isFavoriteBlog(1))
            .thenAnswer((_) async => true);

        final result = await blogListRepository.isFavoriteBlog(1);

        expect(result, true);
        verify(() => mockLocalDataSource.isFavoriteBlog(1)).called(1);
      });

      test('returns false if the blog is not favorite', () async {
        when(() => mockLocalDataSource.isFavoriteBlog(1))
            .thenAnswer((_) async => false);

        final result = await blogListRepository.isFavoriteBlog(1);

        expect(result, false);
        verify(() => mockLocalDataSource.isFavoriteBlog(1)).called(1);
      });
    });

    group('removeFavoriteBlog', () {
      test('removes a blog from favorites', () async {
        when(() => mockLocalDataSource.removeFavoriteBlog(1))
            .thenAnswer((_) async {});

        await blogListRepository.removeFavoriteBlog(1);

        verify(() => mockLocalDataSource.removeFavoriteBlog(1)).called(1);
      });
    });

    group('saveFavoriteBlog', () {
      test('saves a blog to favorites', () async {
        when(() => mockLocalDataSource.saveFavoriteBlog(testBlog))
            .thenAnswer((_) async {});

        await blogListRepository.saveFavoriteBlog(testBlog);

        verify(() => mockLocalDataSource.saveFavoriteBlog(testBlog)).called(1);
      });
    });
  });
}
