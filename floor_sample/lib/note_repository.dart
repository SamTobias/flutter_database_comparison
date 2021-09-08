import 'package:floor_sample/local_datasource.dart';
import 'package:floor_sample/note.dart';
import 'package:floor_sample/note_dao.dart';

class NoteRepository {
  final LocalDatasource _localDatasource;

  NoteRepository(this._localDatasource);

  Future<NoteDAO> _getDao() async {
    final database = await _localDatasource.getDatabase();
    return database.noteDao;
  }

  Future<void> insert(Note note) async {
    final dao = await _getDao();
    dao.insertNote(note);
  }

  Future<void> delete(Note note) async {
    final dao = await _getDao();
    dao.deleteNote(note);
  }

  Future<void> update(Note note) async {
    final dao = await _getDao();
    dao.updateNote(note);
  }

  Future<List<Note>> getAll() async {
    final dao = await _getDao();
    return await dao.getAll();
  }

  Future<Note?> getById(int id) async {
    final dao = await _getDao();
    return await dao.getById(id);
  }
}
