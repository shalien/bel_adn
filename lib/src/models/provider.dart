import 'dart:convert';
import '../dao/model.dart';

class Provider extends Model {
  final int? _topicId;
  int? get topicId => _topicId;

  final String _type;

  String get type => _type;

  final String _link;

  String get link => _link;

  Provider(this._topicId, this._type, this._link, {id}) : super(id: id);

  factory Provider.fromJson(Map json) {
    String link = json['link'];

    return Provider(json['topic_id'], json['type'], link, id: json['id']);
  }

  @override
  String toJson() {
    return json.encode({
      ...?id != null ? {'id': id} : null,
      ...?topicId != null ? {'topic_id': topicId} : null,
      'type': type,
      'link': link
    });
  }
}
