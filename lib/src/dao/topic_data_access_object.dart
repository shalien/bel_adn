import 'dart:convert';

import '../data_access_object.dart';
import '../models/topic.dart';
import '../response_exception.dart';

/// Private instance
TopicDataAccessObject? _topicDataAccessObject;

/// The [DataAccessObject] for the [Topic] class
class TopicDataAccessObject extends DataAccessObject<Topic> {
  TopicDataAccessObject._(String host) : super(host, "topics");

  /// Factory used to create and a single instance during the program run
  factory TopicDataAccessObject(String host) {
    return _topicDataAccessObject ??= TopicDataAccessObject._(host);
  }

  /// Will destroy the [Topic] from the server
  @override
  Future<bool> destroy(Topic t) async {
    String uri = '$resourceUrl/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.delete(url, headers: headers);

    return response.statusCode == 200;
  }

  /// Will return all the [Topic] from the server
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
    } else {
      throw ResponseException(response);
    }

    return topics;
  }

  /// Will return the [Topic] for the given [id]
  @override
  Future<Topic> show(int id) async {
    String uri = '$resourceUrl/$id';
    Uri url = Uri.parse(uri);

    var response = await client.get(url, headers: headers);

    if (response.statusCode != 200) {
      throw ResponseException(response);
    }
    return Topic.fromJson(json.decode(response.body));
  }

  /// Will store the given [Topic]
  @override
  Future<int> store(Topic t) async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    var response = await client.post(url, body: t.toJson(), headers: headers);

    if (response.statusCode != 200) {
      throw ResponseException(response);
    }
    return json.decode(response.body)['id'];
  }

  /// Will update the [Topic]
  @override
  Future<bool> update(Topic t) {
    return Future.value(false);
  }
}
