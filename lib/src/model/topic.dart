import 'dart:convert';

import '../dao/provider_data_access_object.dart';
import '../dao/topic_data_access_object.dart';
import '../model.dart';
import 'provider.dart';

class Topic extends Model {
  static TopicDataAccessObject dao = TopicDataAccessObject();

  final String name;

  final int order;

  Future<List<Provider>> get providers async =>
      await ProviderDataAccessObject().getByTopicId(id!);

  Topic(this.name, this.order,
      {int? id, DateTime? createdAt, DateTime? updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      json['name'],
      json['order'],
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
