

part of '../data_access_object.dart';

final class PathDataAccessObject extends DataAccessObject<Path> {

  const PathDataAccessObject(MagnifiqueCoupleClient client) : super('paths', client);

  @override
  Path fromJson(Map<String, dynamic> json) {
    return Path.fromJson(json);
  }

  Future<List<Source>> sources(Path path) async {
    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/paths/${path.id}/sources');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    }

    List<Source> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) => Source.fromJson(model)).toList();
    }  else {

      throw MagnifiqueException(response);
    }

    return models;
  }

  Future<List<Topic>> topics(Path path) async {
    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/paths/${path.id}/topics');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    }

    List<Topic> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) => Topic.fromJson(model)).toList();
    } else {

      throw MagnifiqueException(response);
    }

    return models;
  }

  Future<List<Supplier>> suppliers(Path path) async {
    final Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/paths/${path.id}/suppliers');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException catch (e) {
      rethrow;
    } on Exception catch (e) {
      rethrow;
    }

    List<Supplier> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) => Supplier.fromJson(model)).toList();
    } else {

    throw MagnifiqueException(response);
    }

    return models;
  }

}