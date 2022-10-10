import '../beau_gosse_client.dart';
import 'model.dart';

abstract class DataAccessObject<T extends Model> {
  final String _prefix;
  final BeauGosseClient _client = BeauGosseClient();

  final Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  String get prefix => _prefix;
  BeauGosseClient get client => _client;

  DataAccessObject(this._prefix);

  Future<List<T>> getAll();

  Future<T> getById(int id);

  Future<bool> update(T t);

  Future<int> store(T t);

  Future<bool> destroy(T t);
}
