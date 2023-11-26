import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'magnifique_couple_client.dart';
import 'model.dart';

part 'dao/destination_data_access_object.dart';
part 'dao/media_data_access_object.dart';
part 'dao/provider_type_data_access_object.dart';
part 'dao/supplier_data_access_object.dart';
part 'dao/path_data_access_object.dart';
part 'dao/source_data_access_object.dart';
part 'dao/topic_data_access_object.dart';
part 'dao/user_data_access_object.dart';


@immutable
abstract base class DataAccessObject<T extends Model> {

  final String endpoint;

  final MagnifiqueCoupleClient _client;

  const DataAccessObject(this.endpoint, this._client);


  @internal
  Future<List<T>> index() async {

    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException catch (e) {
     rethrow;
    } on Exception catch (e) {
      rethrow;
    }

    List<T> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) => fromJson(model)).toList();
    }

    return models;

  }

  @internal
  Future<T> show(int id) async {

    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/$id');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    }

    T model;

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      model = fromJson(json);
    } else {
      throw Exception('Failed to load $endpoint $id');
    }

    return model;

  }

  @internal
  Future<T> store(T model) async {

    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint');

    Response response;

    try {
      response = await _client.post(uri, body: model.toJson());
    } on ClientException catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    }

    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      model = fromJson(json);
    } else {
      throw Exception('Failed to create $endpoint');
    }

    return model;

  }

  @internal
  Future<T> update(T model) async {

    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/${model.id}');

    Response response;

    try {
      response = await _client.put(uri, body: model.toJson());
    } on ClientException catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      model = fromJson(json);
    } else {
      throw Exception('Failed to update $endpoint ${model.id}');
    }

    return model;

  }

  @internal
  Future<void> delete(int id) async {

    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/$id');

    Response response;

    try {
      response = await _client.delete(uri);
    } on ClientException catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    }

    if (response.statusCode != 204) {
      throw Exception('Failed to delete $endpoint $id');
    }

  }


  @internal
  @mustBeOverridden
  T fromJson(Map<String, dynamic> json);

}
