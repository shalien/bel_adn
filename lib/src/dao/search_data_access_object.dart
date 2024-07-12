part of '../data_access_object.dart';

@immutable
final class SearchDataAccessObject extends DataAccessObject<Search> {
  const SearchDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'searches');

  @override
  Search fromJson(Map<String, dynamic> json) {
    return Search.fromJson(json);
  }

  @override
  Future<List<Search>> index(
      {int? topicId, int? pathId, int? supplierId, int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (topicId != null) 'topic_id': topicId.toString(),
      if (pathId != null) 'path_id': pathId.toString(),
      if (supplierId != null) 'supplier_id': supplierId.toString(),
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

    List<Search> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Search modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<Search> update(int id, {String? content, String? sha256}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri,
          body: jsonEncode({
            if (content != null) 'content': content,
            if (sha256 != null) 'sha256': sha256,
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
      final dynamic json = jsonDecode(response.body)['data'];
      final Search model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<Search> store({content, sha256}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri,
          body: jsonEncode({
            'content': content,
            'sha256': sha256,
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
      final dynamic json = jsonDecode(response.body)['data'];
      final Search model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }
}
