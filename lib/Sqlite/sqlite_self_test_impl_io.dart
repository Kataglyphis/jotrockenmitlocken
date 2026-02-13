import 'package:sqlite3/sqlite3.dart';

Future<String> runSqliteSelfTestImpl() async {
  final db = sqlite3.openInMemory();
  try {
    db.execute('CREATE TABLE t (id INTEGER PRIMARY KEY, name TEXT NOT NULL);');
    db.execute('INSERT INTO t (name) VALUES (?)', ['hello']);

    final row = db.select(
      'SELECT id, name, sqlite_version() AS v FROM t LIMIT 1;',
    );

    final id = row.first['id'];
    final name = row.first['name'];
    final version = row.first['v'];

    return 'OK (native): id=$id name=$name sqlite=$version';
  } finally {
    db.dispose();
  }
}
