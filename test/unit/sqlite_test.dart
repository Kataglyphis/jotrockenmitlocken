// The native half of ANThology's SQLite self-test, as /sqliteTest runs it; a Chrome run serves no sqlite3.wasm.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:anthology/Sqlite/sqlite_self_test.dart';

void main() {
  test('the self test runs a query in memory, natively', () async {
    final String result = await runSqliteSelfTest();
    expect(result, startsWith('OK (native): id=1 name=hello sqlite='));
  });
}
