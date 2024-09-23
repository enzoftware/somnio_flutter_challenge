import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:somnio_flutter_challenge/core/providers/providers.dart';
import 'package:somnio_flutter_challenge/features/blog_list/data/data.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/repository/blog_list_repository.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/repository/blog_list_repository_impl.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/use_case/fetch_blogs_use_case.dart';
import 'package:somnio_flutter_challenge/features/blog_list/domain/use_case/toggle_favorite_blog_use_case.dart';

part 'blog_list_provider.g.dart';

@riverpod
BlogListRemoteDataSource remoteDataSource(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return BlogListRemoteDataSource(client: apiClient);
}

@riverpod
BlogListLocalDataSource localDataSource(Ref ref) {
  final storage = ref.read(sharedStorageProvider);
  if (storage == null) {
    throw Exception('');
  }
  return BlogListLocalDataSource(storage: storage);
}

@riverpod
BlogListRepository blogListRepository(Ref ref) {
  final remoteDataSource = ref.read(remoteDataSourceProvider);
  final localDataSource = ref.read(localDataSourceProvider);

  return BlogListRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}

@riverpod
FetchBlogsUseCase blogListUseCase(Ref ref) {
  final repository = ref.read(blogListRepositoryProvider);
  return FetchBlogsUseCase(repository: repository);
}

@riverpod
ToggleFavoriteBlogUseCase toggleFavoriteBlogUseCase(Ref ref) {
  final repository = ref.read(blogListRepositoryProvider);
  return ToggleFavoriteBlogUseCase(repository: repository);
}
