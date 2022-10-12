import 'dart:convert';

import '../model.dart';

/// A [Provider] is a source for a [Topic]
/// Each [Provider] may have it's own resolving method
class Provider extends Model {
  /// The [Topic] to which the [Provider] is associated
  final int? _topicId;
  int? get topicId => _topicId;

  final String _type;

  String get type => _type;

  final String _link;

  String get link => _link;

  Provider(this._topicId, this._type, this._link, {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  Provider.fromJson(Map json)
      : _topicId = json['topic_id'],
        _type = json['type'],
        _link = json['link'],
        super.fromJson(json);

  @override
  String toJson() {
    return json.encode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt} : null,
      ...?topicId != null ? {'topic_id': topicId} : null,
      'type': type,
      'link': link
    });
  }
}
