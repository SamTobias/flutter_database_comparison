import 'dart:io';

import 'package:moor_sample/note.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            await m.addColumn(notes, notes.active);
          }
        },
      );

  Future<void> insertNote(Note note) => into(notes).insert(note);

  Future<void> updateNote(Note note) => update(notes).replace(note);

  Future<void> markAsCompleted(int id) =>
      (update(notes)..where((note) => note.id.equals(id)))
          .write(const NotesCompanion(completed: Value(true)));

  Future<void> deleteNote(int id) =>
      (delete(notes)..where((note) => note.id.equals(id))).go();

  Future<List<Note>> get getAllNotes => select(notes).get();

  Future<Note?> getNoteById(int id) =>
      (select(notes)..where((note) => note.id.equals(id))).getSingleOrNull();
}
