// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkClientHash() => r'3b9fc778e5ba4aef00a1d5c122947b7885e39574';

/// See also [networkClient].
@ProviderFor(networkClient)
final networkClientProvider = AutoDisposeProvider<Dio>.internal(
  networkClient,
  name: r'networkClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NetworkClientRef = AutoDisposeProviderRef<Dio>;
String _$sharedPreferencesHash() => r'6ce59273c68beeba8a8e6226dc3ff98ef8ac9d71';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<SharedPreferences?>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = AutoDisposeProviderRef<SharedPreferences?>;
String _$sharedStorageHash() => r'1f16c0b11394d047d3ffcfa7982133e2fb66933b';

/// See also [sharedStorage].
@ProviderFor(sharedStorage)
final sharedStorageProvider = AutoDisposeProvider<Storage?>.internal(
  sharedStorage,
  name: r'sharedStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedStorageRef = AutoDisposeProviderRef<Storage?>;
String _$apiClientHash() => r'2c149b99ff7091050dac9051b48a3c180e8d494b';

/// See also [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = AutoDisposeProvider<ApiClient>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApiClientRef = AutoDisposeProviderRef<ApiClient>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
