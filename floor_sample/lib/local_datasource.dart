import 'package:floor_sample/app_database.dart';

class LocalDatasource {
  AppDatabase? _database;

  Future<AppDatabase> getDatabase() async {
    if (_database == null) {
      _database = await $FloorAppDatabase.databaseBuilder('app_database.db')
          .addMigrations([migration1to2]).build();
    }

    return _database!;
  }
}