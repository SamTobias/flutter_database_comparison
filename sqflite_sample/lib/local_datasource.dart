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

          _createNotesTableV2(batch);

          return batch.commit();
        },
        onUpgrade: (db, oldVersion, newVersion) {
          final batch = db.batch();

          if (oldVersion == 1) {
            _updateNotesTableV1toV2(batch);
          }
          
          return batch.commit();
        },
        onDowngrade: onDatabaseDowngradeDelete,
        version: 2,
      );
    }

    return _database!;
  }

  void _createNotesTableV2(Batch batch) {
    batch.execute(
      "CREATE TABLE notes (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, text TEXT NOT NULL, date TEXT NOT NULL, completed INTEGER NOT NULL DEFAULT FALSE, active INTEGER NOT NULL DEFAULT TRUE)",
    );
  }

  void _updateNotesTableV1toV2(Batch batch) {
    batch.execute("ALTER TABLE notes ADD COLUMN active INTEGER NOT NULL DEFAULT TRUE");
  }

  Future close() async => _database?.close();
}
