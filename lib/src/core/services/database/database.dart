abstract class Database<T> {
  Stream<T> stream(String uid);
  Future<void> update(String uid, T newData);
  Future<void> save(T data);
  Future<void> delete(T data);
}
