import 'package:floor/floor.dart';
import 'package:floor_sample/note.dart';

@dao
abstract class NoteDAO {

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);

  @Query("UPDATE notes SET completed = 1 WHERE id = :id")
  Future<void> markAsCompleted(int id);

  @delete
  Future<void> deleteNote(Note note);

  @Query("SELECT * FROM notes")
  Future<List<Note>> getAll();

  @Query("SELECT * FROM notes WHERE id = :id")
  Future<Note?> getById(int id);
}
