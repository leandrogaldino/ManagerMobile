import 'package:manager_mobile_app/src/shared/database/database_result.dart';

abstract class LocalDB {
  Future<DatabaseResult> insert(String sql, [List<Object?>? arguments]);
  Future<DatabaseResult> update(String sql, [List<Object?>? arguments]);
  Future<DatabaseResult> delete(String sql, [List<Object?>? arguments]);
  Future<DatabaseResult> query(String sql, [List<Object?>? arguments]);
  Future<void> startTransaction();
  Future<void> commitTransaction();
  Future<void> rollbackTransaction();
}
