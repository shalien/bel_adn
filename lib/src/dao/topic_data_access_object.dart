import 'package:meta/meta.dart';

import 'data_access_object.dart';
import '../models/topic.dart';

/// Private instance
TopicDataAccessObject? _topicDataAccessObject;

/// The [DataAccessObject] for the [Topic] class
@immutable
class TopicDataAccessObject extends DataAccessObject<Topic> {
  TopicDataAccessObject._(String host) : super(host, "topics");

  /// Factory used to create and a single instance during the program run
  factory TopicDataAccessObject(String host) {
    return _topicDataAccessObject ??= TopicDataAccessObject._(host);
  }

  /// Will update the [Topic]
  @override
  Future<bool> update(Topic t) {
    return Future.value(false);
  }
}
