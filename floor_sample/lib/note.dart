import 'package:floor/floor.dart';

@Entity(tableName: "notes")
class Note {
  @primaryKey
  final int? id;
  final String text;
  final DateTime date;
  final bool completed;
  final bool active; // Field added with version 2

  Note({required this.text, required this.date, this.completed = false, this.active = true, this.id});
}