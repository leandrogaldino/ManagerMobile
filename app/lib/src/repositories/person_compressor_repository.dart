import 'package:manager_mobile_app/src/models/person_compressor_model.dart';
import 'package:manager_mobile_app/src/repositories/person_compressor_coalescent_repository.dart';
import 'package:manager_mobile_app/src/repositories/repository.dart';
import 'package:manager_mobile_app/src/shared/database/sqflite_db.dart';
import 'package:manager_mobile_app/src/shared/database/sql/person_compressor_sql.dart';

class PersonCompressorRepository implements Repository<PersonCompressorModel> {
  final SqfliteDB db;
  final PersonCompressorCoalescentRepository coalescentRepository;

  PersonCompressorRepository({required this.db, required this.coalescentRepository});

  @override
  Future<PersonCompressorModel?> delete(PersonCompressorModel model) async {
    int deletedRows = await db.connection.rawDelete(
      PersonCompressorSQL.delete,
      [
        model.id,
      ],
    );
    return deletedRows == 1 ? null : model;
  }

  @override
  Future<List<PersonCompressorModel>> getAll() async {
    var mapListR = await db.connection.rawQuery(PersonCompressorSQL.selectAll);
    var mapList = await SqfliteDB.resultToMapList(mapListR);
    for (var map in mapList) {
      var coalescentList = await coalescentRepository.getByParentId(map['id'] as int);
      map['coalescents'] = coalescentList.map((coalescent) => coalescent.toMap()).toList();
    }
    return mapList.map((e) => PersonCompressorModel.fromMap(e)).toList();
  }

  @override
  Future<PersonCompressorModel?> getById(int id) async {
    List<Map<String, Object?>> result;
    result = await db.connection.rawQuery(PersonCompressorSQL.selectById, [id]);
    if (result.length == 1) {
      Map<String, Object?> map = result[0];
      var coalescentList = await coalescentRepository.getByParentId(map['personid'] as int);
      map['coalescents'] = coalescentList.map((coalescent) => coalescent.toMap()).toList();
      return PersonCompressorModel.fromMap(map);
    } else {
      return null;
    }
  }

  @override
  Future<PersonCompressorModel> save(PersonCompressorModel model) async {
    PersonCompressorModel savingModel;
    int id;
    id = await db.connection.rawInsert(
      PersonCompressorSQL.insert,
      [
        model.id,
        model.personId,
        model.name,
      ],
    );
    savingModel = model.copyWith(id: id);

    for (var coalescent in savingModel.coalescents) {
      coalescent = await coalescentRepository.save(coalescent);
    }

    return savingModel;
  }

//TODO: Daqui pra baixo nao fiz
  @override
  Future<PersonCompressorModel> update(PersonCompressorModel model) async {
    await db.connection.rawInsert(PersonCompressorSQL.update, [
      model.name,
      model.id,
    ]);
    return model;
  }

  Future<List<PersonCompressorModel>> getByParentId(int parentId) async {
    var result = await db.connection.rawQuery(
      PersonCompressorSQL.selectByPersonId,
      [
        parentId,
      ],
    );
    return result.map((e) => PersonCompressorModel.fromMap(e)).toList();
  }
}
