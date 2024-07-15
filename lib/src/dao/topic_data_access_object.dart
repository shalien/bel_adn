part of '../data_access_object.dart';

/// The [DataAccessObject] for the [Topic] class
@immutable
final class TopicDataAccessObject extends DataAccessObject<Topic> {
  const TopicDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'topics');

  @override
  Topic fromJson(Map<String, dynamic> json) {
    return Topic.fromJson(json);
  }

  @override
  Future<List<Topic>> index({String? name, int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (name != null) 'name': name,
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

    List<Topic> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Topic modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<Topic> update(int id, {String? name, int? order}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri,
          body: jsonEncode({
            if (name != null) 'name': name,
            if (order != null) 'order': order,
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
      final Topic model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<Topic> store({name, order}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri,
          body: jsonEncode({
            'name': name,
            'order': order,
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
      final Topic model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }
}
