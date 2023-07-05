import 'dart:convert';

import '../dao/topic_data_access_object.dart';
import '../model.dart';
import 'provider.dart';
import 'topic_alias.dart';

class Topic extends Model {
  static TopicDataAccessObject dao = TopicDataAccessObject();

  final String name;

  final int order;

  List<Provider> _providers = [];

  Future<List<Provider>> get providers async {
    if (_providers.isEmpty) {
      _providers = await Topic.dao.showWithProvider(this);
    }
    return _providers;
  }

  List<TopicAlias> _aliases = [];

  Future<List<TopicAlias>> get aliases async {
    if (_aliases.isEmpty) {
      _aliases = await Topic.dao.showWithAliases(this);
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
