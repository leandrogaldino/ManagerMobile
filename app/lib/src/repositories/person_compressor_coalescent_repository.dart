import 'package:manager_mobile_app/src/models/person_compressor_coalescent_model.dart';
import 'package:manager_mobile_app/src/repositories/repository_by_parent.dart';
import 'package:manager_mobile_app/src/shared/database/localdb.dart';
import 'package:manager_mobile_app/src/shared/database/sql/person_compressor_coalescent_sql.dart';

class PersonCompressorCoalescentRepository implements RepositoryByParent<PersonCompressorCoalescentModel> {
  final LocalDB db;

  PersonCompressorCoalescentRepository({required this.db});

  @override
  Future<PersonCompressorCoalescentModel?> delete(PersonCompressorCoalescentModel model) async {
    var result = await db.delete(
      PersonCompressorCoalescentSQL.delete,
      [
        model.id,
      ],
    );

    return result.affectedRows == 1 ? null : model;
  }

  @override
  Future<List<PersonCompressorCoalescentModel>> getAll() async {
    var result = await db.query(PersonCompressorCoalescentSQL.selectAll);
    return result.dataSet!.map((e) => PersonCompressorCoalescentModel.fromMap(e)).toList();
  }

  @override
  Future<PersonCompressorCoalescentModel?> getById(int id) async {
    var result = await db.query(PersonCompressorCoalescentSQL.selectById, [id]);
    if (result.dataSet!.length == 1) {
      Map<String, Object?> map = result.dataSet![0];
      return PersonCompressorCoalescentModel.fromMap(map);
    } else {
      return null;
    }
  }

  @override
  Future<PersonCompressorCoalescentModel> save(PersonCompressorCoalescentModel model) async {
    PersonCompressorCoalescentModel savingModel;
    var result = await db.insert(
      PersonCompressorCoalescentSQL.insert,
      [
        model.id,
        model.personCompressorId,
        model.name,
      ],
    );
    savingModel = model.copyWith(id: result.lastInsertedRowId);
    return savingModel;
  }

  @override
  Future<PersonCompressorCoalescentModel> update(PersonCompressorCoalescentModel model) async {
    await db.update(PersonCompressorCoalescentSQL.update, [
      model.name,
      model.id,
    ]);
    return model;
  }

  @override
  Future<List<PersonCompressorCoalescentModel>> getByParentId(int parentId) async {
    var result = await db.query(
      PersonCompressorCoalescentSQL.selectByCompressorId,
      [
        parentId,
      ],
    );
    return result.dataSet!.map((e) => PersonCompressorCoalescentModel.fromMap(e)).toList();
  }
}
