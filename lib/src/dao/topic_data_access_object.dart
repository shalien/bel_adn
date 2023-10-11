import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../data_access_object.dart';
import '../model/provider.dart';
import '../model/topic.dart';
import '../model/topic_alias.dart';

/// The [DataAccessObject] for the [Topic] class
@immutable
class TopicDataAccessObject extends DataAccessObject<Topic> {
  static TopicDataAccessObject? _topicDataAccessObject;

  TopicDataAccessObject._(String host, Client client)
      : super(resource: "topics", host: host, client: client);

  /// Factory used to create and a single instance during the program run
  factory TopicDataAccessObject(String host, Client client) {
    return _topicDataAccessObject ??= TopicDataAccessObject._(host, client);
  }

  Future<Set<Provider>> showWithProvider(Topic topic) async {
    Uri uri = Uri.parse("$resourceUrl/${topic.id}/providers");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      Set<Provider> providers = (jsonDecode(response.body)['data'] as List)
          .map((e) => Provider.fromJson(e))
          .toSet();

      return providers;
    } else {
      throw Exception("Failed to load providers");
    }
  }

  Future<Set<TopicAlias>> showWithAliases(Topic topic) async {
    Uri uri = Uri.parse("$resourceUrl/${topic.id}/alias");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      Set<TopicAlias> aliases = (jsonDecode(response.body)['data'] as List)
          .map((e) => TopicAlias.fromJson(e))
          .toSet();

      return aliases;
    } else {
      throw Exception("Failed to load aliases");
    }
  }
}
