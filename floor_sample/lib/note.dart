import 'package:floor/floor.dart';

@Entity(tableName: "notes")
class Note {
  @primaryKey
  final int? id;
  final String text;
  final DateTime date;
  final bool completed;

  Note({required this.text, required this.date, this.completed = false, this.id});
}