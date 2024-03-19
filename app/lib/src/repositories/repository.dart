abstract class Repository<T> {
  Future<T> save(T model);
  Future<T> update(T model);
  Future<T?> delete(T model);
  Future<T?> getById(int id);
  Future<List<T>> getAll();
}
