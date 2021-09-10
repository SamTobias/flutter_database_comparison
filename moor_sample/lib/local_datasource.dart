import 'package:moor_sample/app_database.dart';

class LocalDatasource {
  final AppDatabase _database;

  LocalDatasource(this._database);

  AppDatabase getDatabase() {
    return _database;
  }
}