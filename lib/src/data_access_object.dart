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
  final MagnifiqueCoupleClient client;

  final Uri baseUri;

  /// The constructor
  const DataAccessObject(
      {required this.endpoint, required this.client, required this.baseUri});

  /// Get all the models
  Future<List<T>> index();

  /// Get a model by its id
  Future<T> show(int id) async {
    T model;

    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.get(uri);
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

  /// Update a model
  Future<T> update(int id);

  /// store a fuckin model
  Future<T> store();

  /// Delete a model
  Future<bool> destroy(int id) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.delete(uri);
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

  @internal
  Uri fromParsedHost([unencodedPath, Map<String, dynamic>? queryParameters]) =>
      Uri(
        scheme: baseUri.scheme,
        host: baseUri.host,
        port: baseUri.port,
        path: unencodedPath,
        queryParameters: queryParameters,
      );
}
