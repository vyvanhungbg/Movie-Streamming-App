abstract class SqlDao<T> {
  Future<T?> insert(T entity);

  Future<T?> findByID(String id);

  Future<int> delete(String id);

  Future<bool> update(T entity);
  Future<List<T>> getAll();
}
