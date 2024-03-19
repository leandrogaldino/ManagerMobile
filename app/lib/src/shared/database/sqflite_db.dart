import 'package:manager_mobile_app/src/shared/database/sql/database_sql.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDB {
  late Database connection;

  SqfliteDB({Database? database}) {
    if (database == null) {
      _initializeDatabase();
    } else {
      connection = database;
    }
  }

  Future<void> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'manager.db');
    connection = await openDatabase(
      join(path),
      version: 1,
      onCreate: DatabaseSQL.createDb,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  static Future<List<Map<String, dynamic>>> resultToMapList(List<Map<String, dynamic>> queryResult) async {
    List<Map<String, dynamic>> listOfMaps = [];

    for (var row in queryResult) {
      Map<String, dynamic> rowMap = {};
      row.forEach((key, value) {
        rowMap[key] = value;
      });
      listOfMaps.add(rowMap);
    }

    return listOfMaps;
  }
}
