import 'dart:collection';

import 'package:bel_adn/bel_adn.dart';

class MagnifiqueCache<K extends int, T extends Model>
    implements MapBase<int, T> {
  UnmodifiableListView<T> get all => UnmodifiableListView(_cache.values);

  final Map<int, T> _cache = const {};

  @override
  T? operator [](Object? key) {
    return _cache[key as int];
  }

  @override
  void operator []=(int key, T value) {
    _cache[key] = value;
  }

  @override
  Iterable<int> get keys => _cache.keys;

  @override
  void clear() {
    _cache.clear();
  }

  @override
  T? remove(Object? key) {
    return _cache.remove(key as int);
  }

  @override
  void addAll(Map<int, T> other) {
    _cache.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<int, T>> newEntries) {
    _cache.addEntries(newEntries);
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return _cache.cast<RK, RV>();
  }

  @override
  bool containsKey(Object? key) {
    return _cache.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return _cache.containsValue(value);
  }

  @override
  Iterable<MapEntry<int, T>> get entries => _cache.entries;

  @override
  void forEach(void Function(int key, T value) action) {
    _cache.forEach(action);
  }

  @override
  bool get isEmpty => _cache.isEmpty;

  @override
  bool get isNotEmpty => _cache.isNotEmpty;

  @override
  int get length => _cache.length;

  @override
  Map<K2, V2> map<K2, V2>(
      MapEntry<K2, V2> Function(int key, T value) transform) {
    return _cache.map(transform);
  }

  @override
  T putIfAbsent(int key, T Function() ifAbsent) {
    return _cache.putIfAbsent(key, ifAbsent);
  }

  @override
  void removeWhere(bool Function(int key, T value) test) {
    _cache.removeWhere(test);
  }

  @override
  T update(int key, T Function(T value) update, {T Function()? ifAbsent}) {
    return _cache.update(key, update, ifAbsent: ifAbsent);
  }

  @override
  void updateAll(T Function(int key, T value) update) {
    _cache.updateAll(update);
  }

  @override
  Iterable<T> get values => _cache.values;
}
