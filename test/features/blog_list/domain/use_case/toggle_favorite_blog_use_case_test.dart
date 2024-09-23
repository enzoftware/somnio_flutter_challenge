import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/repository/blog_list_repository.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/use_case/toggle_favorite_blog_use_case.dart';

class MockBlogListRepository extends Mock implements BlogListRepository {}

void main() {
  late MockBlogListRepository mockRepository;
  late ToggleFavoriteBlogUseCase toggleFavoriteBlogUseCase;

  const testBlog = Blog(
    id: 1,
    title: 'Test Blog',
    body: 'This is a test blog',
    isFavorite: false,
  );

  setUp(() {
    mockRepository = MockBlogListRepository();
    toggleFavoriteBlogUseCase =
        ToggleFavoriteBlogUseCase(repository: mockRepository);
  });

  group('ToggleFavoriteBlogUseCase', () {
    test('should add the blog to favorites if it is not a favorite', () async {
      when(() => mockRepository.isFavoriteBlog(testBlog.id!))
          .thenAnswer((_) async => false);
      when(() => mockRepository.saveFavoriteBlog(testBlog))
          .thenAnswer((_) async => {});

      await toggleFavoriteBlogUseCase.execute(blog: testBlog);

      verify(() => mockRepository.saveFavoriteBlog(testBlog)).called(1);
      verifyNever(() => mockRepository.removeFavoriteBlog(any()));
    });

    test('should remove the blog from favorites if it is a favorite', () async {
      when(() => mockRepository.isFavoriteBlog(testBlog.id!))
          .thenAnswer((_) async => true);
      when(() => mockRepository.removeFavoriteBlog(testBlog.id!))
          .thenAnswer((_) async => {});

      await toggleFavoriteBlogUseCase.execute(blog: testBlog);

      verify(() => mockRepository.removeFavoriteBlog(testBlog.id!)).called(1);
      verifyNever(() => mockRepository.saveFavoriteBlog(testBlog));
    });

    test(
        'should throw an exception if repository throws during isFavoriteBlog check',
        () async {
      when(() => mockRepository.isFavoriteBlog(testBlog.id!))
          .thenThrow(Exception('Error'));

      expect(() => toggleFavoriteBlogUseCase.execute(blog: testBlog),
          throwsA(isA<Exception>()));
      verify(() => mockRepository.isFavoriteBlog(testBlog.id!)).called(1);
    });
  });
}
