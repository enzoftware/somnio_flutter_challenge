import 'package:somnio_flutter_challenge/core/core.dart';

/// {@template blog_list_remote_data_source}
/// A data source for fetching blog posts from a remote API using [ApiClient].
///
/// Interacts with the remote server to retrieve a list of blog posts.
/// {@endtemplate}
class BlogListRemoteDataSource {
  /// {@macro blog_list_remote_data_source}
  BlogListRemoteDataSource({required ApiClient client}) : _client = client;

  /// The underlying API client used for making HTTP requests.
  final ApiClient _client;

  /// Fetches a list of blog posts from the remote server.
  ///
  /// The request is made to the `/posts` endpoint.
  ///
  /// Returns a list of [Blog] instances.
  ///
  /// Throws an [ApiClientException] if the request fails.
  Future<List<Blog>> fetchBlogNews() async {
    final response = await _client.makeRequest<List<dynamic>>(
      endpoint: '/posts',
    );
    return (response.data ?? []).map((e) => Blog.fromJson(e)).toList();
  }
}
