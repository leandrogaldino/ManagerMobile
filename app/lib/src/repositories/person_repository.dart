import 'package:manager_mobile_app/src/models/person_model.dart';
import 'package:manager_mobile_app/src/repositories/repository.dart';
import 'package:manager_mobile_app/src/shared/database/sqflite_db.dart';
import 'package:manager_mobile_app/src/shared/database/sql/person_compressor_sql.dart';
import 'package:manager_mobile_app/src/shared/database/sql/person_sql.dart';

class PersonRepository implements Repository<PersonModel> {
  final SqfliteDB db;

  PersonRepository({required this.db});

  @override
  Future<List<PersonModel>> getAll() async {
    var persons = await db.connection.rawQuery(PersonSQL.selectAll);
    return persons.map((e) => PersonModel.fromMap(e)).toList();
  }

  @override
  Future<PersonModel?> getById(int id) async {
    List<Map<String, Object?>> result;
    result = await db.connection.rawQuery(PersonSQL.selectById, [id]);
    if (result.length == 1) {
      Map<String, Object?> personMap = result[0];
      result = await db.connection.rawQuery(PersonCompressorSQL.selectByPersonId, [id]);
      if (result.isNotEmpty) {
        personMap['compressors'] = result;
      }
    } else {
      return null;
    }
  }

  @override
  Future<PersonModel> delete(PersonModel model) async {
    throw UnimplementedError();
  }

  @override
  Future<PersonModel> save(PersonModel model) async {
    PersonModel savingModel = model.copyWith();
    int id;
    db.connection.transaction(
      (txn) async {
        id = await txn.rawInsert(PersonSQL.insert, [
          model.id,
          model.document,
          model.name,
          model.isTechnician ? 1 : 0,
          model.isCustomer ? 1 : 0,
        ]);
        savingModel = savingModel.copyWith(id: id);

        for (var compressor in savingModel.compressors) {
          id = await txn.rawInsert('sql');
          compressor = compressor.copyWith(id: id);
        }
      },
    );

    return savingModel;
  }

  @override
  Future<PersonModel> update(PersonModel model) async {
    await db.connection.rawInsert(PersonSQL.update, [
      model.document,
      model.name,
      model.isTechnician ? 1 : 0,
      model.isCustomer ? 1 : 0,
      model.id,
    ]);
    return model;
  }
}
