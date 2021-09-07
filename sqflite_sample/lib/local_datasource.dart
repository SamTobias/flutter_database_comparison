import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource {
  Database? _database;

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'note_database.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE notes(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT NOT NULL, date TEXT NOT NULL, completed INTEGER NOT NULL DEFAULT FALSE)",
          );
        },
        version: 1,
      );
    }

    return _database!;
  }

  Future close() async => _database?.close();
}
