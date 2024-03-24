class DatabaseResult {
  int? affectedRows;
  int? lastInsertedRowId;
  List<Map<String, dynamic>>? dataSet;

  DatabaseResult({this.affectedRows, this.lastInsertedRowId, this.dataSet});
}
