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

  final String endpoint;

  final MagnifiqueCoupleClient _client;

  const DataAccessObject(this.endpoint, this._client);

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
      models = json.map((dynamic model) => fromJson(model)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;

  }


  Future<T> show(int id) async {

    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/$id');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    T model;

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      model = fromJson(json);
    } else {
      throw MagnifiqueException(response);
    }

    return model;

  }

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

  Future<T> update(T model) async {

    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/${model.id}');

    Response response;

    try {
      response = await _client.put(uri, body: model.toJson());
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


  Future<void> delete(int id) async {

    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/$id');

    Response response;

    try {
      response = await _client.delete(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode != 204) {
      throw MagnifiqueException(response);
    }

  }


  @internal
  @mustBeOverridden
  T fromJson(Map<String, dynamic> json);

}
