import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somnio_flutter_challenge/core/local/shared_storage.dart';
import 'package:somnio_flutter_challenge/core/local/storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late Storage sharedStorage;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sharedStorage = SharedStorage(sharedPreferences: mockSharedPreferences);
  });

  group('SharedStorage', () {
    const testKey = 'testKey';
    const testList = ['item1', 'item2', 'item3'];

    group('getListString', () {
      test('returns list of strings when found in SharedPreferences', () async {
        when(() => mockSharedPreferences.getStringList(testKey))
            .thenReturn(testList);

        final result = await sharedStorage.getListString(testKey);

        expect(result, testList);
        verify(() => mockSharedPreferences.getStringList(testKey)).called(1);
      });

      test('returns empty list when no data is found', () async {
        when(() => mockSharedPreferences.getStringList(testKey))
            .thenReturn(null);

        final result = await sharedStorage.getListString(testKey);

        expect(result, isEmpty);
        verify(() => mockSharedPreferences.getStringList(testKey)).called(1);
      });

      test('throws StorageException when an exception occurs', () async {
        when(() => mockSharedPreferences.getStringList(testKey))
            .thenThrow(Exception('Error'));

        expect(
          () async => await sharedStorage.getListString(testKey),
          throwsA(isA<StorageException>()),
        );

        verify(() => mockSharedPreferences.getStringList(testKey)).called(1);
      });
    });

    group('writeListString', () {
      test('writes list of strings to SharedPreferences', () async {
        when(() => mockSharedPreferences.setStringList(testKey, testList))
            .thenAnswer((_) async => true);

        await sharedStorage.writeListString(testKey, testList);

        verify(() => mockSharedPreferences.setStringList(testKey, testList))
            .called(1);
      });

      test('throws StorageException when an exception occurs', () async {
        when(() => mockSharedPreferences.setStringList(testKey, testList))
            .thenThrow(Exception('Error'));

        expect(
          () async => await sharedStorage.writeListString(testKey, testList),
          throwsA(isA<StorageException>()),
        );

        verify(() => mockSharedPreferences.setStringList(testKey, testList))
            .called(1);
      });
    });
  });
}
