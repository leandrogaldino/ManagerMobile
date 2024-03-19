class TechnicianSQL {
  TechnicianSQL._();

  static String get insert => '''
    INSERT INTO technician (
      personid,
      evaluationid
    ) VALUES (
      ?,
      ?
    )
    ''';

  static String get selectByEvaluationId => '''
    SELECT
      technician.id mainid,
      person.id id,
      person.document,
      person.name,
      technician.evaluationid 
    FROM technician
    LEFT JOIN person ON person.id = technician.personid
    WHERE technician. evaluationid = ?
    ''';

  static String get delete => 'DELETE FROM technician WHERE personid = ? AND evaluationid = ?';
}
