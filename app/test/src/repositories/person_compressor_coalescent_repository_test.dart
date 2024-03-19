import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:manager_mobile_app/src/models/person_compressor_coalescent_model.dart';
import 'package:manager_mobile_app/src/repositories/person_compressor_coalescent_repository.dart';
import 'package:manager_mobile_app/src/shared/database/sqflite_db.dart';
import 'package:manager_mobile_app/src/shared/database/sql/database_sql.dart';

void main() {
  late Database database;
  late SqfliteDB sqfliteDb;
  late PersonCompressorCoalescentRepository repository;
  late PersonCompressorCoalescentModel? model;
  late List<PersonCompressorCoalescentModel> models;
  setUpAll(
    () async {
      sqfliteFfiInit();
      var options = OpenDatabaseOptions();
      options.onCreate = DatabaseSQL.createDb;
      options.version = 1;
      database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath, options: options);
      sqfliteDb = SqfliteDB(database: database);
      repository = PersonCompressorCoalescentRepository(db: sqfliteDb);
    },
  );

  test(
    'Save person compressor coalescent',
    () async {
      model = PersonCompressorCoalescentModel(id: 1, personCompressorId: 1, name: 'EFS 70U');
      model = await repository.save(model!);
      expect(model!.id, 1);
      model = PersonCompressorCoalescentModel(id: 2, personCompressorId: 1, name: 'EFS 70H');
      model = await repository.save(model!);
      expect(model!.id, 2);
      model = PersonCompressorCoalescentModel(id: 3, personCompressorId: 2, name: 'EFS 125U');
      model = await repository.save(model!);
      expect(model!.id, 3);
      model = PersonCompressorCoalescentModel(id: 4, personCompressorId: 2, name: 'EFS 125H');
      model = await repository.save(model!);
      expect(model!.id, 4);
    },
  );
  test(
    'Get all person compressor coalescents',
    () async {
      models = await repository.getAll();
      expect(models.length, equals(4));
      expect(models[0].id, 1);
      expect(models[0].name, 'EFS 70U');
      expect(models[1].id, 2);
      expect(models[1].name, 'EFS 70H');
      expect(models[2].id, 3);
      expect(models[2].name, 'EFS 125U');
      expect(models[3].id, 4);
      expect(models[3].name, 'EFS 125H');
    },
  );
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
}
