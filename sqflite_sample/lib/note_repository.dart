import 'package:sqflite_sample/note.dart';
import 'package:sqflite_sample/note_dao.dart';

class NoteRepository {
  final NoteDAO _noteDao;

  NoteRepository(this._noteDao);

  void insert(Note note) {
    _noteDao.insert(note);
  }

  void delete(int id) {
    _noteDao.delete(id);
  }

  void update(Note note) {
    _noteDao.update(note);
  }

  Future<List<Note>> getAll() async {
    return await _noteDao.getAll();
  }

  Future<Note> getById(int id) async {
    return await _noteDao.getById(id);
  }
}
