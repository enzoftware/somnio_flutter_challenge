import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somnio_flutter_challenge/core/core.dart';
import 'package:somnio_flutter_challenge/core/local/shared_storage.dart';
import 'package:somnio_flutter_challenge/core/local/storage.dart';

part 'providers.g.dart';

@riverpod
Dio networkClient(Ref ref) {
  return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
}

@riverpod
SharedPreferences? sharedPreferences(SharedPreferencesRef ref) {
  return null;
}

@riverpod
Storage? sharedStorage(Ref ref) {
  final sp = ref.read(sharedPreferencesProvider);
  if (sp == null) {
    throw Exception('SharedPreferences not provided.');
  }
  return SharedStorage(sharedPreferences: sp);
}

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.read(networkClientProvider);
  return ApiClient(dio: dio);
}
