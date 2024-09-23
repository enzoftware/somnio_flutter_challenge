/// {@template storage}
/// An abstract interface for local storage operations.
/// {@endtemplate}
abstract class Storage {
  /// Retrieves a list of strings from storage for a given key.
  ///
  /// If no data is found, an empty list is returned.
  ///
  /// Throws a [StorageException] if an error occurs during the operation.
  Future<List<String>> getListString(String key);

  /// Writes a list of strings to storage for a given key.
  ///
  /// Throws a [StorageException] if an error occurs during the operation.
  Future<void> writeListString(String key, List<String> value);
}
