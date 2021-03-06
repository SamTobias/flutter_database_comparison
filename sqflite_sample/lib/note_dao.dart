import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sample/local_datasource.dart';
import 'package:sqflite_sample/note.dart';

class NoteDAO {
  final LocalDatasource _datasource;

  NoteDAO(this._datasource);

  Future<void> insert(Note note) async {
    final database = await _datasource.getDatabase();
    await database.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Note note) async {
    final database = await _datasource.getDatabase();
    await database
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> markAsCompleted(int id) async {
    final database = await _datasource.getDatabase();
    // await database.rawUpdate("UPDATE notes SET completed = 1 WHERE id = ?", [id]);
    await database.update("notes", {"completed": 1},
        where: "id = ?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final database = await _datasource.getDatabase();
    database.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Note>> getAll() async {
    final database = await _datasource.getDatabase();
    final List<Map<String, dynamic>> maps = await database.query("notes");
    return List.generate(maps.length, (index) {
      return Note(
        text: maps[index]['text'],
        date: DateTime.parse(maps[index]['date']),
        completed: maps[index]['completed'] == 1,
        active: maps[index]['active'] == 1,
        id: maps[index]['id'],
      );
    });
  }

  Future<Note?> getById(int id) async {
    final database = await _datasource.getDatabase();
    // final List<Map<String, dynamic>> list = await database.rawQuery("SELECT * FROM notes WHERE id = ?", [id]);
    final List<Map<String, dynamic>> list =
        await database.query("notes", where: "'id = ?'", whereArgs: [id]);

    if (list.length == 0) {
      return null;
    }

    final note = list[0];

    return Note(
      text: note['text'],
      date: DateTime.parse(note['date']),
      completed: note['completed'] == 1,
      active: note['active'] == 1,
      id: note['id'],
    );
  }
}
