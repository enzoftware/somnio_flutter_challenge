import 'package:shared_preferences/shared_preferences.dart';

import 'storage.dart';

/// {@template storage_exception}
/// Exception thrown if a storage operation fails.
/// {@endtemplate}
class StorageException implements Exception {
  /// {@macro storage_exception}
  const StorageException(this.error);

  /// Error thrown during the storage operation.
  final Object error;
}

/// {@template shared_storage}
/// A concrete implementation of the [Storage] interface using
/// [SharedPreferences] as the underlying storage mechanism.
/// {@endtemplate}
class SharedStorage implements Storage {
  /// {@macro shared_storage}
  SharedStorage({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<List<String>> getListString(String key) async {
    try {
      return _sharedPreferences.getStringList(key) ?? [];
    } catch (e) {
      throw StorageException(e);
    }
  }

  @override
  Future<void> writeListString(String key, List<String> value) async {
    try {
      _sharedPreferences.setStringList(key, value);
    } catch (e) {
      throw StorageException(e);
    }
  }
}
