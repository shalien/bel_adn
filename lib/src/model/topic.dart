import 'dart:convert';

import '../dao/topic_data_access_object.dart';
import '../model.dart';
import 'provider.dart';
import 'topic_alias.dart';

class Topic extends Model {
  final String name;

  int order;

  Future<Set<Provider>> get providers async =>
      await TopicDataAccessObject().showWithProvider(this);

  Set<TopicAlias> _aliases = {};

  Future<Set<TopicAlias>> get aliases async {
    if (_aliases.isEmpty) {
      _aliases = await TopicDataAccessObject().showWithAliases(this);
    }
    return _aliases;
  }

  Topic(
      {required this.name,
      required this.order,
      int? id,
      DateTime? createdAt,
      DateTime? updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      name: json['name'],
      order: json['order'],
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  @override
  String toJson() {
    return json.encode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'name': name,
      'order': order,
    });
  }
}
