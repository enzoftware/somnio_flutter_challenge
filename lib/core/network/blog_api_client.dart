import 'package:dio/dio.dart';

/// {@template api_client_exception}
/// Exception thrown when an error occurs during an API request.
/// {@endtemplate}
class ApiClientException implements Exception {
  /// {@macro api_client_exception}
  const ApiClientException({required this.message});

  /// The error message associated with the exception.
  final String message;
}

/// {@template api_client}
/// A client for making API requests using [Dio].
///
/// It supports making requests to different endpoints with configurable
/// headers, query parameters, and HTTP methods.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  const ApiClient({required Dio dio}) : _dio = dio;

  /// The underlying Dio instance used for making requests.
  final Dio _dio;

  /// Makes an API request to the given [endpoint].
  ///
  /// The request can be customized using [method], [headers], and [queryParameters].
  ///
  /// Throws an [ApiClientException] if the request fails with a Dio-specific error.
  Future<Response<T>> makeRequest<T>({
    required String endpoint,
    String method = 'GET',
    Map<String, String>? headers,
    Map<String, Object> queryParameters = const {},
  }) async {
    try {
      return _dio.request(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers ??
              {
                'accept': 'application/json',
              },
          method: method,
        ),
      );
    } on DioException catch (e) {
      throw ApiClientException(message: e.message ?? 'unknown error');
    }
  }
}
