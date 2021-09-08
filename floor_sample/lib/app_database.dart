import 'dart:async';

import 'package:floor/floor.dart';
import 'package:floor_sample/date_time_converter.dart';
import 'package:floor_sample/note.dart';
import 'package:floor_sample/note_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Note])
abstract class AppDatabase extends FloorDatabase {
  NoteDAO get noteDao;
}
