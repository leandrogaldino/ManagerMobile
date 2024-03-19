import 'package:flutter_test/flutter_test.dart';
import 'package:manager_mobile_app/src/models/person_compressor_model.dart';
import 'package:manager_mobile_app/src/repositories/person_compressor_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:manager_mobile_app/src/models/person_compressor_coalescent_model.dart';
import 'package:manager_mobile_app/src/repositories/person_compressor_coalescent_repository.dart';
import 'package:manager_mobile_app/src/shared/database/sqflite_db.dart';
import 'package:manager_mobile_app/src/shared/database/sql/database_sql.dart';

void main() {
  late Database database;
  late SqfliteDB sqfliteDb;
  late PersonCompressorCoalescentRepository coalescentRepository;
  late PersonCompressorRepository compressorRepository;
  late PersonCompressorModel? model;
  late List<PersonCompressorModel> models;
  setUpAll(
    () async {
      sqfliteFfiInit();
      var options = OpenDatabaseOptions();
      options.onCreate = DatabaseSQL.createDb;
      options.version = 1;
      database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath, options: options);
      sqfliteDb = SqfliteDB(database: database);
      coalescentRepository = PersonCompressorCoalescentRepository(db: sqfliteDb);
      compressorRepository = PersonCompressorRepository(db: sqfliteDb, coalescentRepository: coalescentRepository);
    },
  );

  test(
    'Save person compressor',
    () async {
      model = PersonCompressorModel(id: 1, personId: 1, name: 'SRP 4015', coalescents: [
        PersonCompressorCoalescentModel(id: 1, personCompressorId: 1, name: 'EFS 70U'),
        PersonCompressorCoalescentModel(id: 2, personCompressorId: 1, name: 'EFS 70H'),
      ]);
      model = await compressorRepository.save(model!);
      expect(model!.id, 1);
      model = PersonCompressorModel(id: 2, personId: 1, name: 'SRP 4030', coalescents: [
        PersonCompressorCoalescentModel(id: 3, personCompressorId: 2, name: 'EFS 125U'),
        PersonCompressorCoalescentModel(id: 4, personCompressorId: 2, name: 'EFS 125H'),
      ]);
      model = await compressorRepository.save(model!);
      expect(model!.id, 2);
      model = PersonCompressorModel(id: 3, personId: 2, name: 'SRP 4050', coalescents: [
        PersonCompressorCoalescentModel(id: 5, personCompressorId: 3, name: 'EFS 340U'),
        PersonCompressorCoalescentModel(id: 6, personCompressorId: 3, name: 'EFS 340H'),
      ]);
      model = await compressorRepository.save(model!);
      expect(model!.id, 3);
      model = PersonCompressorModel(id: 4, personId: 2, name: 'SRP 4100', coalescents: [
        PersonCompressorCoalescentModel(id: 7, personCompressorId: 4, name: 'EFS 470U'),
        PersonCompressorCoalescentModel(id: 8, personCompressorId: 4, name: 'EFS 470H'),
      ]);
      model = await compressorRepository.save(model!);
      expect(model!.id, 4);
    },
  );

  test(
    'Get all person compressor coalescents',
    () async {
      models = await compressorRepository.getAll();

      models.forEach(print);

      /*expect(models[0].id, 1);
      expect(models[0].personId, 1);
      expect(models[0].name, 'SRP 4015');
      expect(models[0].coalescents[0].id, 1);
      expect(models[0].coalescents[0].personCompressorId, 1);
      expect(models[0].coalescents[0].name, 'EFS 70U');
      expect(models[0].coalescents[1].id, 2);
      expect(models[0].coalescents[0].personCompressorId, 1);
      expect(models[0].coalescents[1].name, 'EFS 70H');

      expect(models[1].id, 2);
      expect(models[1].personId, 1);
      expect(models[1].name, 'SRP 4030');

      expect(models[2].id, 3);
      expect(models[2].personId, 2);
      expect(models[2].name, 'SRP 4050');

      expect(models[3].id, 4);
      expect(models[3].personId, 2);
      expect(models[3].name, 'SRP 4100');
      */
    },
  );
  /*
  test(
    'Get person compressor coalescent by id',
    () async {
      model = await repository.getById(3);
      expect(model, isNotNull);
      expect(model!.id, isNotNull);
      expect(model!.personCompressorId, 2);
      expect(model!.name, 'EFS 125U');
    },
  );

  test(
    'Get person compressor coalescent by compressor id',
    () async {
      models = await repository.getByParentId(2);
      expect(models.length, equals(2));
      expect(models[0].id, 3);
      expect(models[0].name, 'EFS 125U');
      expect(models[1].id, 4);
      expect(models[1].name, 'EFS 125H');
    },
  );

  test(
    'Update person compressor coalescent',
    () async {
      model = model!.copyWith(id: 1, name: 'SRP 4100');
      model = await repository.update(model!);
      model = await repository.getById(1);
      expect(model, isNotNull);
      expect(model!.id, equals(1));
      expect(model!.personCompressorId, equals(1));
      expect(model!.name, equals('SRP 4100'));
    },
  );

  test(
    'Delete person compressor coalescent',
    () async {
      model = await repository.delete(model!);
      expect(model, isNull);
    },
  );
  */
}
