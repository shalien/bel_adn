part of '../data_access_object.dart';

@immutable
final class PathDataAccessObject extends DataAccessObject<Path> {
  const PathDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'paths');

  @override
  Path fromJson(Map<String, dynamic> json) {
    return Path.fromJson(json);
  }

  Future<List<Search>> searches(Path path) async {
    final Uri uri = fromParsedHost('/api/$endpoint/${path.id}/searches');

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Search> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) => Search.fromJson(model)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<List<Path>> index({String? content, int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (content != null) 'content': content,
      if (page != null) 'page': page.toString(),
    });

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Path> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Path modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
