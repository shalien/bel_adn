import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';
import 'package:meta/meta.dart';

import '../data_access_object.dart';
import '../model/topic.dart';

/// The [DataAccessObject] for the [Topic] class
@immutable
class TopicDataAccessObject extends DataAccessObject<Topic> {
  static TopicDataAccessObject? _topicDataAccessObject;

  TopicDataAccessObject._() : super(resource: "topics");

  /// Factory used to create and a single instance during the program run
  factory TopicDataAccessObject() {
    return _topicDataAccessObject ??= TopicDataAccessObject._();
  }

  Future<List<Provider>> showWithProvider(Topic topic) async {
    Uri uri = Uri.parse("${topic.id}/providers");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      List<Provider> providers = (jsonDecode(response.body)['data'] as List)
          .map((e) => Provider.fromJson(e))
          .toList();

      return providers;
    } else {
      throw Exception("Failed to load providers");
    }
  }

  Future<List<TopicAlias>> showWithAliases(Topic topic) async {
    Uri uri = Uri.parse("${topic.id}/topic_aliases");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      List<TopicAlias> aliases = (jsonDecode(response.body)['data'] as List)
          .map((e) => TopicAlias.fromJson(e))
          .toList();

      return aliases;
    } else {
      throw Exception("Failed to load aliases");
    }
  }
}
