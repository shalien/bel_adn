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

  Future<List<Search>> searches(Topic topic) async {
    final Uri uri =
    Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/${topic.id}/searches');

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
      models = json.map((dynamic model) => Search.fromJson(model, client: _client)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

}
