class EvaluationSQL {
  EvaluationSQL._();
  static String get insert => '''
    INSERT INTO evaluation (
      customerid,
      compressorid, 
      starttime, 
      endtime, 
      horimeter,
      airfilter,
      oilfilter,
      separator,
      oiltype,
      oil,
      technicaladvice,
      responsible,
      signature
    ) VALUES (
      ?,
      ?,
      ?,
      ?,
      ?,
      ?,
      ?,
      ?,
      ?,
      ?,
      ?,
      ?,
      ?
    )
    ''';

  static String get update => '''
    UPDATE evaluation SET
      customerid = ?,
      compressorid = ?,
      starttime = ?,
      endtime = ?,
      horimeter = ?,
      airfilter = ?,
      oilfilter = ?,
      separator = ?,
      oiltype = ?,
      oil = ?,
      technicaladvice = ?,
      responsible = ?,
      signature = ?
    WHERE
      id = ?
    ''';
  static String get selectAll => '''
    SELECT
      id,
      customerid,
      compressorid,
      starttime,
      endtime,
      horimeter,
      airfilter,
      oilfilter,
      separator,
      oiltype,
      oil,
      technicaladvice,
      signature
    FROM evaluation
    ''';

  static String get selectById => '$selectAll WHERE id = ?';

  static String get delete => 'DELETE FROM evaluation WHERE id = ?';
}
