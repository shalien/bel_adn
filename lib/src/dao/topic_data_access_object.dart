part of '../data_access_object.dart';

/// The [DataAccessObject] for the [Topic] class
@immutable
final class TopicDataAccessObject extends DataAccessObject<Topic> {
  const TopicDataAccessObject(MagnifiqueCoupleClient client)
      : super('topics', client);

  @override
  Topic fromJson(Map<String, dynamic> json) {
    return Topic.fromJson(json);
  }

  Future<List<Path>> paths(Topic topic) async {
    final Uri uri =
        Uri.https(MagnifiqueCoupleClient.host, '/api/topics/${topic.id}/paths');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Path> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) => Path.fromJson(model)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
