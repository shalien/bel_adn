import '../data_access_object.dart';
import '../model/topic_alias.dart';

final class TopicAliasDataAccessObject extends DataAccessObject<TopicAlias> {
  static TopicAliasDataAccessObject? _topicAliasDataAccessObject;

  TopicAliasDataAccessObject._() : super(resource: 'topic_aliases');

  factory TopicAliasDataAccessObject() {
    return _topicAliasDataAccessObject ??= TopicAliasDataAccessObject._();
  }
}
