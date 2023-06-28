import '../model.dart';

final class Cache<T extends Model> {
  static final Map<Type, Cache> _instances = {};

  final Map<int, T> _cache = {};

  Cache._();

  factory Cache() {
    final type = T;

    if (_instances.containsKey(type)) {
      return _instances[type] as Cache<T>;
    } else {
      final cache = Cache<T>._();
      _instances[type] = cache;
      return cache;
    }
  }

  T? get(int id) => _cache[id];

  bool replace(T t) {
    if (t.id == null) {
      throw Exception('Cannot cache a model without an id');
    } else if (!_cache.containsKey(t.id!)) {
      return false;
    } else {
      _cache[t.id!] = t;
      return true;
    }
  }

  bool isCached(int id) => _cache.containsKey(id);

  void add(T t) => t.id == null
      ? throw Exception('Cannot cache a model without an id')
      : _cache[t.id!] = t;

  List<T?> find(bool Function(T) test) => _cache.values.where(test).toList();

  void removeWhere(bool Function(T) test) =>
      _cache.removeWhere((_, t) => test(t));

  void remove(int id) => _cache.remove(id);

  void clear() => _cache.clear();

  void addAll(List<T> list) => list.forEach(add);

  void addIfAbsent(T t) => _cache.putIfAbsent(t.id!, () => t);

  void addAllIfAbsent(List<T> list) => list.forEach(addIfAbsent);
}
