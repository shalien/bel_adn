part of '../data_access_object.dart';

@immutable
final class PathDataAccessObject extends DataAccessObject<Path> {
  const PathDataAccessObject(MagnifiqueCoupleClient client)
      : super('paths', client);

  @override
  Path fromJson(Map<String, dynamic> json) {
    return Path.fromJson(json, _client);
  }

  Future<List<Search>> searches(Path path) async {
    final Uri uri = Uri.https(
        MagnifiqueCoupleClient.host, '/api/$endpoint/${path.id}/searches');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Search> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models =
          json.map((dynamic model) => Search.fromJson(model, _client)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
