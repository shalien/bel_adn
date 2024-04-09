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
  Future<List<Topic>> index({String? name}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (name != null) 'name': name,
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

  Future<List<Search>> searches(Topic topic) async {
    final Uri uri = fromParsedHost('/api/$endpoint/${topic.id}/searches');

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
}
