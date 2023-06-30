import 'dart:convert';

import '../dao/provider_data_access_object.dart';
import '../dao/topic_data_access_object.dart';
import '../model.dart';
import 'provider.dart';
import 'topic_alias.dart';

class Topic extends Model {
  static TopicDataAccessObject dao = TopicDataAccessObject();

  final String name;

  final int order;

  List<int?> get aliasesId => aliases.map((e) => e.id).toList();

  List<TopicAlias> aliases = [];

  Future<List<Provider>> get providers async =>
      await ProviderDataAccessObject().getByTopicId(id!);

  Topic(
      {required this.name,
      required this.order,
      required this.aliases,
      int? id,
      DateTime? createdAt,
      DateTime? updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Topic.fromJson(Map<String, dynamic> json) {
    List<TopicAlias> aliases = json['topic_aliases'] == null
        ? []
        : (json['topic_aliases'] as List)
            .map((e) => TopicAlias.fromJson(e))
            .toList();

    return Topic(
      name: json['name'],
      order: json['order'],
      id: json['id'],
      aliases: aliases,
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
