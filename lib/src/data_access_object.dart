import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'exception/magnifique_exception.dart';
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
part 'dao/search_data_access_object.dart';

@immutable
abstract base class DataAccessObject<T extends Model> {
  /// The endpoint of the DAO
  final String endpoint;

  /// The client used to make requests
  final MagnifiqueCoupleClient _client;

  /// The constructor
  const DataAccessObject(this.endpoint, this._client);

  /// Get all the models
  Future<List<T>> index() async {
    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<T> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        T modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  /// Get a model by its id
  Future<T> show(int id) async {
    T model;

    final Uri uri =
        Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/$id');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      model = fromJson(json);
    } else {
      throw MagnifiqueException(response);
    }

    return model;
  }

  /// Store a model
  Future<T> store(T model) async {
    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint');

    Response response;

    try {
      response = await _client.post(uri, body: model.toJson());
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      model = fromJson(json);
    } else {
      throw MagnifiqueException(response);
    }

    return model;
  }

  /// Update a model
  Future<T> update(int id, T updatedModel) async {
    final Uri uri =
        Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/$id');

    Response response;
    T model;

    try {
      response = await _client.put(uri, body: updatedModel.toJson());
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      model = fromJson(json);
    } else {
      throw MagnifiqueException(response);
    }

    return model;
  }

  /// Delete a model
  Future<bool> delete(int id) async {
    final Uri uri =
        Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/$id');

    Response response;

    try {
      response = await _client.delete(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode != 204 && response.statusCode != 404) {
      throw MagnifiqueException(response);
    }

    return true;
  }

  /// Convert a json to a model
  @internal
  @mustBeOverridden
  T fromJson(Map<String, dynamic> json);
}
