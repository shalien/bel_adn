part of '../data_access_object.dart';

@immutable
final class SourceDataAccessObject extends DataAccessObject<Source> {
  const SourceDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'sources');

  @override
  Source fromJson(Map<String, dynamic> json) {
    return Source.fromJson(json);
  }

  @override
  Future<List<Source>> index(
      {Uri? link,
      int? pathId,
      int? topicId,
      int? supplierId,
      int? searchId,
      int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (link != null) 'link': link.toString(),
      if (pathId != null) 'path_id': pathId.toString(),
      if (topicId != null) 'topic_id': topicId.toString(),
      if (supplierId != null) 'supplier_id': supplierId.toString(),
      if (searchId != null) 'search_id': searchId.toString(),
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

    List<Source> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Source modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<Source> update(int id,
      {Uri? link,
      int? pathId,
      int? topicId,
      int? supplierId,
      int? searchId}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri,
          body: jsonEncode({
            if (link != null) 'link': link.toString(),
            if (pathId != null) 'path_id': pathId.toString(),
            if (topicId != null) 'topic_id': topicId.toString(),
            if (supplierId != null) 'supplier_id': supplierId.toString(),
            if (searchId != null) 'search_id': searchId.toString(),
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
      final Source model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<Source> store({link, pathId, topicId, supplierId, searchId}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri,
          body: jsonEncode({
            'link': link.toString(),
            'path_id': pathId.toString(),
            'topic_id': topicId.toString(),
            'supplier_id': supplierId.toString(),
            'search_id': searchId.toString(),
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
      final Source model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }
}
