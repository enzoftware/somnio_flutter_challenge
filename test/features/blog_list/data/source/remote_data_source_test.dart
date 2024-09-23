import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/features/blog_list/data/data.dart';
import 'package:dio/dio.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  late MockApiClient mockApiClient;
  late BlogListRemoteDataSource remoteDataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    remoteDataSource = BlogListRemoteDataSource(client: mockApiClient);
  });

  group('BlogListRemoteDataSource', () {
    const testEndpoint = '/posts';

    final testBlogJson = {
      'id': 1,
      'title': 'Test Blog',
      'body': 'This is a test blog',
      'isFavorite': false
    };

    const testBlog = Blog(
      id: 1,
      title: 'Test Blog',
      body: 'This is a test blog',
      isFavorite: false,
    );

    test('fetchBlogNews returns a list of blogs on success', () async {
      final mockResponse = MockResponse<List<dynamic>>();
      when(() => mockResponse.data).thenReturn([testBlogJson]);
      when(() => mockApiClient.makeRequest<List<dynamic>>(
            endpoint: testEndpoint,
          )).thenAnswer((_) async => mockResponse);

      final blogs = await remoteDataSource.fetchBlogNews();

      expect(blogs, equals([testBlog]));
      verify(() =>
              mockApiClient.makeRequest<List<dynamic>>(endpoint: testEndpoint))
          .called(1);
    });

    test('fetchBlogNews returns an empty list when no data is available',
        () async {
      final mockResponse = MockResponse<List<dynamic>>();
      when(() => mockResponse.data).thenReturn([]);
      when(() => mockApiClient.makeRequest<List<dynamic>>(
            endpoint: testEndpoint,
          )).thenAnswer((_) async => mockResponse);

      final blogs = await remoteDataSource.fetchBlogNews();

      expect(blogs, isEmpty);
      verify(() =>
              mockApiClient.makeRequest<List<dynamic>>(endpoint: testEndpoint))
          .called(1);
    });

    test('throws ApiClientException on failure', () async {
      when(() => mockApiClient.makeRequest<List<dynamic>>(
                endpoint: testEndpoint,
              ))
          .thenThrow(
              const ApiClientException(message: 'Failed to fetch blogs'));

      expect(
        () async => await remoteDataSource.fetchBlogNews(),
        throwsA(isA<ApiClientException>()),
      );

      verify(() =>
              mockApiClient.makeRequest<List<dynamic>>(endpoint: testEndpoint))
          .called(1);
    });
  });
}
