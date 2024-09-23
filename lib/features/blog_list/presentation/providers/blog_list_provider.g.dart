// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remoteDataSourceHash() => r'7c882e683b569edd9521d87f4f967ba712dc48ee';

/// See also [remoteDataSource].
@ProviderFor(remoteDataSource)
final remoteDataSourceProvider =
    AutoDisposeProvider<BlogListRemoteDataSource>.internal(
  remoteDataSource,
  name: r'remoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RemoteDataSourceRef = AutoDisposeProviderRef<BlogListRemoteDataSource>;
String _$localDataSourceHash() => r'deea3d82c057dbaedc78c64b5a61213591da2e5e';

/// See also [localDataSource].
@ProviderFor(localDataSource)
final localDataSourceProvider =
    AutoDisposeProvider<BlogListLocalDataSource>.internal(
  localDataSource,
  name: r'localDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalDataSourceRef = AutoDisposeProviderRef<BlogListLocalDataSource>;
String _$blogListRepositoryHash() =>
    r'f09b25c7c387a0fcddaadeb9252302662e4decb6';

/// See also [blogListRepository].
@ProviderFor(blogListRepository)
final blogListRepositoryProvider =
    AutoDisposeProvider<BlogListRepository>.internal(
  blogListRepository,
  name: r'blogListRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$blogListRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BlogListRepositoryRef = AutoDisposeProviderRef<BlogListRepository>;
String _$blogListUseCaseHash() => r'e4adb1303ddbc2140670400ecc0ba1ec92c1517d';

/// See also [blogListUseCase].
@ProviderFor(blogListUseCase)
final blogListUseCaseProvider = AutoDisposeProvider<FetchBlogsUseCase>.internal(
  blogListUseCase,
  name: r'blogListUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$blogListUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BlogListUseCaseRef = AutoDisposeProviderRef<FetchBlogsUseCase>;
String _$toggleFavoriteBlogUseCaseHash() =>
    r'd4b5e07e3b68a53e57ea0820337c339c29a8f7f8';

/// See also [toggleFavoriteBlogUseCase].
@ProviderFor(toggleFavoriteBlogUseCase)
final toggleFavoriteBlogUseCaseProvider =
    AutoDisposeProvider<ToggleFavoriteBlogUseCase>.internal(
  toggleFavoriteBlogUseCase,
  name: r'toggleFavoriteBlogUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$toggleFavoriteBlogUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ToggleFavoriteBlogUseCaseRef
    = AutoDisposeProviderRef<ToggleFavoriteBlogUseCase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
