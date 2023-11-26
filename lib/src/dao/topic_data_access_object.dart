part of '../data_access_object.dart';

/// The [DataAccessObject] for the [Topic] class
@immutable
final class TopicDataAccessObject extends DataAccessObject<Topic> {

  const TopicDataAccessObject(MagnifiqueCoupleClient client) : super('topics', client);

  @override
  Topic fromJson(Map<String, dynamic> json) {
    return Topic.fromJson(json);
  }

}
