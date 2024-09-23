import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:somnio_flutter_challenge/core/core.dart';

class MockDio extends Mock implements Dio {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  late Dio mockDio;
  late ApiClient apiClient;

  setUp(() {
    mockDio = MockDio();
    apiClient = ApiClient(dio: mockDio);

    // Register fallback values for RequestOptions as mocktail requires this
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('ApiClient', () {
    const testEndpoint = '/test-endpoint';
    final testQueryParameters = {'param1': 'value1'};

    test('makes a successful request', () async {
      final mockResponse = MockResponse<Map<String, dynamic>>();

      // Simulate a successful response
      when(() => mockResponse.data).thenReturn({'key': 'value'});
      when(() => mockDio.request<Map<String, dynamic>>(
            testEndpoint,
            queryParameters: testQueryParameters,
            options: any(named: 'options'),
          )).thenAnswer((_) async => mockResponse);

      final response = await apiClient.makeRequest<Map<String, dynamic>>(
        endpoint: testEndpoint,
        queryParameters: testQueryParameters,
      );

      expect(response, equals(mockResponse));
      verify(() => mockDio.request<Map<String, dynamic>>(
            testEndpoint,
            queryParameters: testQueryParameters,
            options: any(named: 'options'),
          )).called(1);
    });

    test('throws ApiClientException on DioException', () async {
      // Simulate a DioException
      when(() => mockDio.request<Map<String, dynamic>>(
            testEndpoint,
            queryParameters: testQueryParameters,
            options: any(named: 'options'),
          )).thenThrow(DioException(
        requestOptions: RequestOptions(path: testEndpoint),
      ));

      expect(
        () async => await apiClient.makeRequest<Map<String, dynamic>>(
          endpoint: testEndpoint,
          queryParameters: testQueryParameters,
        ),
        throwsA(isA<ApiClientException>()),
      );

      verify(() => mockDio.request<Map<String, dynamic>>(
            testEndpoint,
            queryParameters: testQueryParameters,
            options: any(named: 'options'),
          )).called(1);
    });

    test('throws ApiClientException with correct message on DioException',
        () async {
      const errorMessage = 'Something went wrong';

      // Simulate a DioException with a message
      when(() => mockDio.request<Map<String, dynamic>>(
            testEndpoint,
            queryParameters: testQueryParameters,
            options: any(named: 'options'),
          )).thenThrow(DioException(
        message: errorMessage,
        requestOptions: RequestOptions(path: testEndpoint),
      ));

      try {
        await apiClient.makeRequest<Map<String, dynamic>>(
          endpoint: testEndpoint,
          queryParameters: testQueryParameters,
        );
      } catch (e) {
        expect(e, isA<ApiClientException>());
        expect((e as ApiClientException).message, errorMessage);
      }

      verify(() => mockDio.request<Map<String, dynamic>>(
            testEndpoint,
            queryParameters: testQueryParameters,
            options: any(named: 'options'),
          )).called(1);
    });
  });
}
