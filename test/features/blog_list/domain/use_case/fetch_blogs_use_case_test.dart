import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/repository/blog_list_repository.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/use_case/fetch_blogs_use_case.dart';

// Mock class for BlogListRepository
class MockBlogListRepository extends Mock implements BlogListRepository {}

void main() {
  late MockBlogListRepository mockRepository;
  late FetchBlogsUseCase fetchBlogsUseCase;

  const testBlogs = [
    Blog(
        id: 1, title: 'Test Blog 1', body: 'This is blog 1', isFavorite: false),
    Blog(
        id: 2, title: 'Test Blog 2', body: 'This is blog 2', isFavorite: false),
  ];

  setUp(() {
    mockRepository = MockBlogListRepository();
    fetchBlogsUseCase = FetchBlogsUseCase(repository: mockRepository);
  });

  group('FetchBlogsUseCase', () {
    test('should fetch blog news from repository', () async {
      // Arrange: Mock the fetchBlogNews method to return testBlogs
      when(() => mockRepository.fetchBlogNews())
          .thenAnswer((_) async => testBlogs);

      // Act: Execute the use case
      final result = await fetchBlogsUseCase.execute();

      // Assert: Verify the result matches testBlogs
      expect(result, testBlogs);
      verify(() => mockRepository.fetchBlogNews()).called(1);
    });

    test('should throw an exception when repository throws', () async {
      // Arrange: Mock the fetchBlogNews method to throw an exception
      when(() => mockRepository.fetchBlogNews())
          .thenThrow(Exception('Failed to fetch blogs'));

      // Act & Assert: Verify that the use case throws the same exception
      expect(() => fetchBlogsUseCase.execute(), throwsA(isA<Exception>()));
      verify(() => mockRepository.fetchBlogNews()).called(1);
    });
  });
}
