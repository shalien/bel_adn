part of '../data_access_object.dart';

@immutable
final class PathDataAccessObject extends DataAccessObject<Path> {
  const PathDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'paths');

  @override
  Path fromJson(Map<String, dynamic> json) {
    return Path.fromJson(json);
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

  @override
  Future<Path> update(int id, {String? content}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri,
          body: jsonEncode({
            if (content != null) 'content': content,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      final Path model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<Path> store({content}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri,
          body: jsonEncode({
            'content': content,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      final Path model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }
}
