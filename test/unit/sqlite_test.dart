import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anthology/Sqlite/sqlite_self_test_impl_io.dart' as impl_io;
import 'package:anthology/Sqlite/sqlite_self_test_impl_stub.dart' as impl_stub;

void main() {
  group('sqlite_self_test_impl_stub', () {
    test('throws UnsupportedError', () {
      expect(
        impl_stub.runSqliteSelfTestImpl(),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });

  group('sqlite_self_test_impl_io', () {
    test('openInMemory creates DB, inserts row, returns OK (native)', () async {
      if (kIsWeb) {
        return;
      }

      final result = await impl_io.runSqliteSelfTestImpl();
      expect(result, contains('OK (native)'));
      expect(result, contains('id=1'));
      expect(result, contains('name=hello'));
    });
  });
}
