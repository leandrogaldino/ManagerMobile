import 'package:sqflite/sqflite.dart';

class DatabaseSQL {
  DatabaseSQL._();

  static void createDb(Database db, int version) async {
    await db.execute(_createPersonTable);
    await db.execute(_createPersonCompressorTable);
    await db.execute(_createPersonCompressorCoalescentTable);
    await db.execute(_createEvaluationTable);
    await db.execute(_createTechnicianTable);
  }

  static String get _createPersonTable => '''
    CREATE TABLE person (
      id INTEGER PRIMARY KEY,
      document TEXT NOT NULL,
      name TEXT NOT NULL,
      istechnician INTEGER NOT NULL,
      iscustomer INTEGER NOT NULL
    )
    ''';
  static String get _createPersonCompressorTable => '''
    CREATE TABLE personcompressor (
      id INTEGER PRIMARY KEY,
      personid INTEGER NOT NULL,
      name TEXT NOT NULL,
      FOREIGN KEY (personid) REFERENCES person(id) ON DELETE CASCADE
    )
    ''';

  static String get _createPersonCompressorCoalescentTable => '''
    CREATE TABLE personcompressorcoalescent (
      id INTEGER PRIMARY KEY,
      personcompressorid INTEGER NOT NULL,
      name TEXT NOT NULL,
      FOREIGN KEY (personcompressorid) REFERENCES personcompressor(id) ON DELETE CASCADE
    )
    ''';

  static String get _createEvaluationTable => '''
    CREATE TABLE evaluation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customerid INTEGER NOT NULL,
    compressorid INTEGER NOT NULL,
    starttime INTEGER NOT NULL,
    endtime INTEGER NOT NULL,
    horimeter INTEGER NOT NULL,
    airfilter INTEGER NOT NULL,
    oilfilter INTEGER NOT NULL,
    separator INTEGER NOT NULL,
    oiltype INTEGER NOT NULL,
    oil INTEGER NOT NULL,
    technicaladvice TEXT,
    responsible INTEGER NOT NULL,
    signature TEXT NOT NULL,
    FOREIGN KEY (customerid) REFERENCES person(id),
    FOREIGN KEY (compressorid) REFERENCES compressor(id)
    )
    ''';
  static String get _createTechnicianTable => '''
    CREATE TABLE technician (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    personid INTEGER NOT NULL,
    evaluationid INTEGER NOT NULL,
    FOREIGN KEY (personid) REFERENCES person(id),
    FOREIGN KEY (evaluationid) REFERENCES evaluation(id) ON DELETE CASCADE,
    UNIQUE (personid, evaluationid)
    )
    ''';
}
