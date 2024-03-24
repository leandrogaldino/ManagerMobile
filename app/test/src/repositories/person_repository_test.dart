import 'package:flutter_test/flutter_test.dart';
import 'package:manager_mobile_app/src/models/person_compressor_coalescent_model.dart';
import 'package:manager_mobile_app/src/models/person_compressor_model.dart';
import 'package:manager_mobile_app/src/models/person_model.dart';
import 'package:manager_mobile_app/src/repositories/person_compressor_coalescent_repository.dart';
import 'package:manager_mobile_app/src/repositories/person_compressor_repository.dart';
import 'package:manager_mobile_app/src/repositories/person_repository.dart';
import 'package:manager_mobile_app/src/shared/database/localdb.dart';
import 'package:manager_mobile_app/src/shared/database/sqflite_db.dart';
import 'package:manager_mobile_app/src/shared/database/sql/database_sql.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;
  late LocalDB db;
  late PersonCompressorCoalescentRepository coalescentRepository;
  late PersonCompressorRepository compressorRepository;
  late PersonRepository personRepository;
  late PersonModel? model;
  setUpAll(() async {
    sqfliteFfiInit();
    var options = OpenDatabaseOptions();
    options.onCreate = DatabaseSQL.createDb;
    options.version = 1;
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath, options: options);
    db = SqfliteDB(database: database);
    coalescentRepository = PersonCompressorCoalescentRepository(db: db);
    compressorRepository = PersonCompressorRepository(db: db, coalescentRepository: coalescentRepository);
    personRepository = PersonRepository(db: db, compressorRepository: compressorRepository);
  });

  test('Save person', () async {
    model = PersonModel(
      id: 1,
      document: '00000000000000',
      name: 'NameA',
      isTechnician: false,
      isCustomer: false,
      compressors: [
        PersonCompressorModel(
          id: 1,
          personId: 1,
          name: 'SRP 4015',
          coalescents: [
            PersonCompressorCoalescentModel(id: 1, personCompressorId: 1, name: 'EFS 70U'),
            PersonCompressorCoalescentModel(id: 2, personCompressorId: 1, name: 'EFS 70H'),
          ],
        ),
        PersonCompressorModel(
          id: 2,
          personId: 1,
          name: 'SRP 4100',
          coalescents: [
            PersonCompressorCoalescentModel(id: 3, personCompressorId: 2, name: 'EFS 470U'),
            PersonCompressorCoalescentModel(id: 4, personCompressorId: 2, name: 'EFS 470H'),
          ],
        ),
      ],
    );
    model = await personRepository.save(model!);
    expect(model!.id, 1);

    model = PersonModel(
      id: 2,
      document: '11111111111111',
      name: 'NameB',
      isTechnician: true,
      isCustomer: true,
      compressors: [
        PersonCompressorModel(
          id: 3,
          personId: 2,
          name: 'SRP 4030',
          coalescents: [
            PersonCompressorCoalescentModel(id: 5, personCompressorId: 3, name: 'EFS 125U'),
            PersonCompressorCoalescentModel(id: 6, personCompressorId: 3, name: 'EFS 125H'),
          ],
        ),
        PersonCompressorModel(
          id: 4,
          personId: 2,
          name: 'SRP 4050',
          coalescents: [
            PersonCompressorCoalescentModel(id: 7, personCompressorId: 4, name: 'EFS 340U'),
            PersonCompressorCoalescentModel(id: 8, personCompressorId: 4, name: 'EFS 340H'),
          ],
        ),
      ],
    );
    model = await personRepository.save(model!);
    expect(model!.id, 2);
  });
}
