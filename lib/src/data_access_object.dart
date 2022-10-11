import 'package:bel_adn/bel_adn.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DataAccessObject<T extends Model> {
  final String _resource;

  final String _host;
  String get host => _host;

  final BelAdnClient _client = BelAdnClient();

  final Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  String get resourceUrl => "$_host/api/$_resource";

  BelAdnClient get client => _client;

  DataAccessObject(this._host, this._resource);

  Future<List<T>> index();

  Future<T> show(int id);

  Future<bool> update(T t);

  Future<int> store(T t);

  Future<bool> destroy(T t);
}
