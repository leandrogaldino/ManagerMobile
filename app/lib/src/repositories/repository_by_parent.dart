import 'package:manager_mobile_app/src/repositories/repository.dart';

abstract class RepositoryByParent<T> implements Repository<T> {
  Future<List<T>> getByParentId(int parentId);
}
