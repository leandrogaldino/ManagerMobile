class PersonCompressorSQL {
  PersonCompressorSQL._();
  static String get insert => '''
    INSERT INTO personcompressor (
      id,
      personid,
      name
    ) VALUES (
      ?,
      ?,
      ?
    )
    ''';

  static String get update => '''
    UPDATE personcompressor SET
      name = ?
    WHERE id = ?
    ''';
  static String get selectAll => '''
    SELECT
      id,
      personid,
      name
    FROM personcompressor
    ''';
  static String get selectById => '$selectAll WHERE `id` = ?';
  static String get selectByPersonId => '$selectAll WHERE personid = ?';

  static String get delete => 'DELETE FROM personcompressor WHERE id = ?';
}
