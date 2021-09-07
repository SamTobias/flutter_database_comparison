import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource {
  Database? _database;

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'note_database.db'),
        onCreate: (db, version) {
          final batch = db.batch();

          _createNotesTableV1(batch);

          return batch.commit();
        },
        version: 1,
      );
    }

    return _database!;
  }

  void _createNotesTableV1(Batch batch) {
    batch.execute(
      "CREATE TABLE notes(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT NOT NULL, date TEXT NOT NULL, completed INTEGER NOT NULL DEFAULT FALSE)",
    );
  }

  Future close() async => _database?.close();
}
