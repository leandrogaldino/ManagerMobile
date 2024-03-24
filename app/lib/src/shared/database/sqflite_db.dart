import 'package:manager_mobile_app/src/shared/database/database_result.dart';
import 'package:manager_mobile_app/src/shared/database/localdb.dart';
import 'package:manager_mobile_app/src/shared/database/sql/database_sql.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDB implements LocalDB {
  late Database _connection;

  SqfliteDB({Database? database}) {
    if (database == null) {
      _initializeDatabase();
    } else {
      _connection = database;
    }
  }

  Future<void> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'manager.db');
    _connection = await openDatabase(
      join(path),
      version: 1,
      onCreate: DatabaseSQL.createDb,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  static Future<List<Map<String, dynamic>>> _resultToMapList(List<Map<String, dynamic>> queryResult) async {
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

  @override
  Future<DatabaseResult> delete(String sql, [List<Object?>? arguments]) async {
    DatabaseResult result = DatabaseResult();
    result.affectedRows = await _connection.rawDelete(sql, arguments);
    return result;
  }

  @override
  Future<DatabaseResult> insert(String sql, [List<Object?>? arguments]) async {
    DatabaseResult result = DatabaseResult();
    result.lastInsertedRowId = await _connection.rawInsert(sql, arguments);
    return result;
  }

  @override
  Future<DatabaseResult> update(String sql, [List<Object?>? arguments]) async {
    DatabaseResult result = DatabaseResult();
    result.affectedRows = await _connection.rawUpdate(sql, arguments);
    return result;
  }

  @override
  Future<DatabaseResult> query(String sql, [List<Object?>? arguments]) async {
    DatabaseResult result = DatabaseResult();
    result.dataSet = await _resultToMapList(await _connection.rawQuery(sql, arguments));
    return result;
  }

  @override
  Future<void> commitTransaction() async {
    await _connection.rawQuery('COMMIT;');
  }

  @override
  Future<void> rollbackTransaction() async {
    await _connection.rawQuery('ROLLBACK;');
  }

  @override
  Future<void> startTransaction() async {
    await _connection.rawQuery('BEGIN TRANSACTION;');
  }
}
