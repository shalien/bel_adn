import 'package:http/http.dart';

import '../data_access_object.dart';
import '../model/topic_alias.dart';

final class TopicAliasDataAccessObject extends DataAccessObject<TopicAlias> {
  static TopicAliasDataAccessObject? _topicAliasDataAccessObject;

  TopicAliasDataAccessObject._(String host, Client client)
      : super(resource: 'topic_aliases', host: host, client: client);

  factory TopicAliasDataAccessObject(String host, Client client) {
    return _topicAliasDataAccessObject ??=
        TopicAliasDataAccessObject._(host, client);
  }
}
