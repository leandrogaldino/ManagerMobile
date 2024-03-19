class PersonSQL {
  PersonSQL._();
  static String get insert => '''
    INSERT INTO person (
      id,
      document,
      name,
      istechnician,
      iscustomer
    ) VALUES (
      ?,
      ?,
      ?,
      ?,
      ?
    )
    ''';

  static String get update => '''
    UPDATE person SET
      document = ?,
      name = ?,
      istechnician = ?,
      iscustomer = ?
     WHERE id = ?
    ''';
  static String get selectAll => '''
    SELECT
      id,
      document,
      name,
      istechnician,
      iscustomer
    FROM person
    ''';

  static String get selectById => '$selectAll WHERE id = ?';

  static String get delete => 'DELETE FROM person WHERE id = ?';
}
