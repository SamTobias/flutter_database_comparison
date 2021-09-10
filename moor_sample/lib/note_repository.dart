import 'package:moor_sample/app_database.dart';
import 'package:moor_sample/local_datasource.dart';

class NoteRepository {
  final LocalDatasource _localDatasource;

  NoteRepository(this._localDatasource);

  AppDatabase _getDao() {
    return _localDatasource.getDatabase();
  }

  Future<void> insert(Note note) async {
    await _getDao().insertNote(note);
  }

  Future<void> delete(Note note) async {
    await _getDao().deleteNote(note.id);
  }

  Future<void> update(Note note) async {
    await _getDao().updateNote(note);
  }

  Future<List<Note>> getAll() async {
    return await _getDao().getAllNotes;
  }

  Future<Note?> getById(int id) async {
    return await _getDao().getNoteById(id);
  }
}
