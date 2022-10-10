import 'bel_adn_client.dart';
import 'model.dart';

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

  Future<List<T>> getAll();

  Future<T> getById(int id);

  Future<bool> update(T t);

  Future<int> store(T t);

  Future<bool> destroy(T t);
}
