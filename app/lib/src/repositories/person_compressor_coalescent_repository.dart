import 'package:manager_mobile_app/src/models/person_compressor_coalescent_model.dart';
import 'package:manager_mobile_app/src/repositories/repository.dart';
import 'package:manager_mobile_app/src/shared/database/sqflite_db.dart';
import 'package:manager_mobile_app/src/shared/database/sql/person_compressor_coalescent_sql.dart';

class PersonCompressorCoalescentRepository implements Repository<PersonCompressorCoalescentModel> {
  final SqfliteDB db;

  PersonCompressorCoalescentRepository({required this.db});

  @override
  Future<PersonCompressorCoalescentModel?> delete(PersonCompressorCoalescentModel model) async {
    int deletedRows = await db.connection.rawDelete(
      PersonCompressorCoalescentSQL.delete,
      [
        model.id,
      ],
    );
    return deletedRows == 1 ? null : model;
  }

  @override
  Future<List<PersonCompressorCoalescentModel>> getAll() async {
    var result = await db.connection.rawQuery(PersonCompressorCoalescentSQL.selectAll);
    return result.map((e) => PersonCompressorCoalescentModel.fromMap(e)).toList();
  }

  @override
  Future<PersonCompressorCoalescentModel?> getById(int id) async {
    List<Map<String, Object?>> result;
    result = await db.connection.rawQuery(PersonCompressorCoalescentSQL.selectById, [id]);
    if (result.length == 1) {
      Map<String, Object?> map = result[0];
      return PersonCompressorCoalescentModel.fromMap(map);
    } else {
      return null;
    }
  }

  @override
  Future<PersonCompressorCoalescentModel> save(PersonCompressorCoalescentModel model) async {
    PersonCompressorCoalescentModel savingModel;
    int id;
    id = await db.connection.rawInsert(
      PersonCompressorCoalescentSQL.insert,
      [
        model.id,
        model.personCompressorId,
        model.name,
      ],
    );
    savingModel = model.copyWith(id: id);
    return savingModel;
  }

  @override
  Future<PersonCompressorCoalescentModel> update(PersonCompressorCoalescentModel model) async {
    await db.connection.rawInsert(PersonCompressorCoalescentSQL.update, [
      model.name,
      model.id,
    ]);
    return model;
  }

  Future<List<PersonCompressorCoalescentModel>> getByParentId(int parentId) async {
    var result = await db.connection.rawQuery(
      PersonCompressorCoalescentSQL.selectByCompressorId,
      [
        parentId,
      ],
    );
    return result.map((e) => PersonCompressorCoalescentModel.fromMap(e)).toList();
  }
}
