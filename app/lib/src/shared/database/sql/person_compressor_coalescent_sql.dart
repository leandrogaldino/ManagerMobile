class PersonCompressorCoalescentSQL {
  PersonCompressorCoalescentSQL._();
  static String get insert => '''
    INSERT INTO `personcompressorcoalescent` (
      `id`,
      `personcompressorid`,
      `name`
    ) VALUES (
      ?,
      ?,
      ?
    )
    ''';

  static String get update => '''
    UPDATE `personcompressorcoalescent` SET
      `name` = ?
     WHERE `id` = ?
    ''';

  static String get selectByCompressorId => '''
    SELECT
      `id`,
      `personcompressorid`,
      `name`
    FROM `personcompressorcoalescent`
    WHERE `personcompressorid` = ?
    ''';

  static String get delete => 'DELETE FROM `personcompressorcoalescent` WHERE `id` = ?';

  static String get selectAll => '''
    SELECT
      `id`,
      `personcompressorid`,
      `name`
    FROM `personcompressorcoalescent`
    ''';

  static String get selectById => '$selectAll WHERE `id` = ?';
}
