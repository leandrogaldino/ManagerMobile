import 'package:manager_mobile_app/src/models/person_compressor_model.dart';
import 'package:manager_mobile_app/src/models/person_model.dart';
import 'package:manager_mobile_app/src/repositories/repository.dart';
import 'package:manager_mobile_app/src/repositories/repository_by_parent.dart';
import 'package:manager_mobile_app/src/shared/database/localdb.dart';
import 'package:manager_mobile_app/src/shared/database/sql/person_sql.dart';

class PersonRepository implements Repository<PersonModel> {
  final LocalDB db;
  final RepositoryByParent<PersonCompressorModel> compressorRepository;

  PersonRepository({required this.db, required this.compressorRepository});

  @override
  Future<List<PersonModel>> getAll() async {
    var result = await db.query(PersonSQL.selectAll);
    return result.dataSet!.map((e) => PersonModel.fromMap(e)).toList();
  }

  @override
  Future<PersonModel?> getById(int id) async {
    var result = await db.query(PersonSQL.selectById, [id]);
    if (result.dataSet!.length == 1) {
      Map<String, Object?> map = result.dataSet![0];
      var compressorList = await compressorRepository.getByParentId(map['personid'] as int);
      map['compressors'] = compressorList.map((coalescent) => coalescent.toMap()).toList();
      return PersonModel.fromMap(map);
    } else {
      return null;
    }
  }

  @override
  Future<PersonModel> delete(PersonModel model) async {
    //TODO
    throw UnimplementedError();
  }

  @override
  Future<PersonModel> save(PersonModel model) async {
    throw UnimplementedError();
  }

  @override
  Future<PersonModel> update(PersonModel model) async {
    throw UnimplementedError();
  }
}
