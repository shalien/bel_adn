import 'dart:convert';

import '../data_access_object.dart';
import '../models/topic.dart';

TopicDataAccessObject? _topicDataAccessObject;

class TopicDataAccessObject extends DataAccessObject<Topic> {
  TopicDataAccessObject._(String host) : super(host, "topics");

  factory TopicDataAccessObject(String host) {
    return _topicDataAccessObject ??= TopicDataAccessObject._(host);
  }

  @override
  Future<bool> destroy(Topic t) async {
    String uri = '$resourceUrl/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.delete(url, headers: headers);

    return response.statusCode == 200;
  }

  @override
  Future<List<Topic>> index() async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    List<Topic> topics = <Topic>[];

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> decodedResponse = json.decode(response.body);

      for (dynamic element in decodedResponse) {
        topics.add(Topic.fromJson(element));
      }
    }

    return topics;
  }

  @override
  Future<Topic> show(int id) async {
    String uri = '$resourceUrl/$id';
    Uri url = Uri.parse(uri);

    var response = await client.get(url, headers: headers);

    if (response.statusCode != 200) {}
    return Topic.fromJson(json.decode(response.body));
  }

  @override
  Future<int> store(Topic t) async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    var response = await client.post(url, body: t.toJson(), headers: headers);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    return json.decode(response.body)['id'];
  }

  @override
  Future<bool> update(Topic t) {
    return Future.value(false);
  }
}
