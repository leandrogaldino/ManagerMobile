import 'package:manager_mobile_app/src/models/person_compressor_coalescent_model.dart';
import 'package:manager_mobile_app/src/models/person_compressor_model.dart';
import 'package:manager_mobile_app/src/repositories/repository_by_parent.dart';
import 'package:manager_mobile_app/src/shared/database/localdb.dart';
import 'package:manager_mobile_app/src/shared/database/sql/person_compressor_sql.dart';

class PersonCompressorRepository implements RepositoryByParent<PersonCompressorModel> {
  final LocalDB db;
  final RepositoryByParent<PersonCompressorCoalescentModel> coalescentRepository;

  PersonCompressorRepository({required this.db, required this.coalescentRepository});

  @override
  Future<PersonCompressorModel?> delete(PersonCompressorModel model) async {
    var result = await db.delete(
      PersonCompressorSQL.delete,
      [
        model.id,
      ],
    );
    return result.affectedRows == 1 ? null : model;
  }

  @override
  Future<List<PersonCompressorModel>> getAll() async {
    var result = await db.query(PersonCompressorSQL.selectAll);
    for (var map in result.dataSet!) {
      var coalescentList = await coalescentRepository.getByParentId(map['id'] as int);
      map['coalescents'] = coalescentList.map((coalescent) => coalescent.toMap()).toList();
    }
    return result.dataSet!.map((e) => PersonCompressorModel.fromMap(e)).toList();
  }

  @override
  Future<PersonCompressorModel?> getById(int id) async {
    var result = await db.query(PersonCompressorSQL.selectById, [id]);
    if (result.dataSet!.length == 1) {
      Map<String, Object?> map = result.dataSet![0];
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
    try {
      await db.startTransaction();
      var result = await db.insert(
        PersonCompressorSQL.insert,
        [
          model.id,
          model.personId,
          model.name,
        ],
      );
      savingModel = model.copyWith(id: result.lastInsertedRowId);
      for (var coalescent in savingModel.coalescents) {
        coalescent = await coalescentRepository.save(coalescent);
      }
      await db.commitTransaction();
      return savingModel;
    } catch (e) {
      await db.rollbackTransaction();
      rethrow;
    }
  }

  Future<void> _updateCoalescents(PersonCompressorModel compressor) async {
    var dbCoalescents = await coalescentRepository.getByParentId(compressor.id);
    List<PersonCompressorCoalescentModel> coalescentsToSave = compressor.coalescents.where((coalescent) => !dbCoalescents.any((dbCoalescent) => dbCoalescent.id == coalescent.id)).toList();
    List<PersonCompressorCoalescentModel> coalescentsToDelete = dbCoalescents.where((dbCoalescent) => !compressor.coalescents.any((coalescent) => coalescent.id == dbCoalescent.id)).toList();
    List<PersonCompressorCoalescentModel> coalescentsToUpdate = compressor.coalescents.where((coalescent) => dbCoalescents.any((dbCoalescent) => dbCoalescent.id == coalescent.id)).toList();
    for (var coalescent in coalescentsToSave) {
      coalescent = await coalescentRepository.save(coalescent);
    }
    for (var coalescent in coalescentsToDelete) {
      await coalescentRepository.delete(coalescent);
    }
    for (var coalescent in coalescentsToUpdate) {
      await coalescentRepository.update(coalescent);
    }
  }

  @override
  Future<PersonCompressorModel> update(PersonCompressorModel model) async {
    PersonCompressorModel updatingModel = model.copyWith();
    try {
      await db.startTransaction();
      await db.update(PersonCompressorSQL.update, [
        updatingModel.name,
        updatingModel.id,
      ]);
      await _updateCoalescents(updatingModel);
      await db.commitTransaction();
      return updatingModel;
    } catch (e) {
      await db.rollbackTransaction();
      rethrow;
    }
  }

  @override
  Future<List<PersonCompressorModel>> getByParentId(int parentId) async {
    var result = await db.query(
      PersonCompressorSQL.selectByPersonId,
      [
        parentId,
      ],
    );
    return result.dataSet!.map((e) => PersonCompressorModel.fromMap(e)).toList();
  }
}
