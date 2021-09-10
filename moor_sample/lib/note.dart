import 'package:moor/moor.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description =>
      text()(); // I had to change column name to "description" due to conflict with text() function
  DateTimeColumn get date => dateTime()();

  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}
