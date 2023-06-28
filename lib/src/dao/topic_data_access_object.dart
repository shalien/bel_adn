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
}
