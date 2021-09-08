// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDAO? _noteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `notes` (`id` INTEGER, `text` TEXT NOT NULL, `date` INTEGER NOT NULL, `completed` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDAO get noteDao {
    return _noteDaoInstance ??= _$NoteDAO(database, changeListener);
  }
}

class _$NoteDAO extends NoteDAO {
  _$NoteDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'notes',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'text': item.text,
                  'date': _dateTimeConverter.encode(item.date),
                  'completed': item.completed ? 1 : 0
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'notes',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'text': item.text,
                  'date': _dateTimeConverter.encode(item.date),
                  'completed': item.completed ? 1 : 0
                }),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'notes',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'text': item.text,
                  'date': _dateTimeConverter.encode(item.date),
                  'completed': item.completed ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  @override
  Future<void> markAsCompleted(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE notes SET completed = 1 WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<List<Note>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM notes',
        mapper: (Map<String, Object?> row) => Note(
            text: row['text'] as String,
            date: _dateTimeConverter.decode(row['date'] as int),
            completed: (row['completed'] as int) != 0,
            id: row['id'] as int?));
  }

  @override
  Future<Note?> getById(int id) async {
    return _queryAdapter.query('SELECT * FROM notes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Note(
            text: row['text'] as String,
            date: _dateTimeConverter.decode(row['date'] as int),
            completed: (row['completed'] as int) != 0,
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(Note note) async {
    await _noteDeletionAdapter.delete(note);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
