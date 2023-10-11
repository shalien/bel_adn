import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';

final class TopicAlias extends Model {
  final int topicId;

  final String alias;

  TopicAlias({
    required this.topicId,
    required this.alias,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TopicAlias.fromJson(Map json) {
    return TopicAlias(
      id: json['id'],
      topicId: json['topic_id'],
      alias: json['alias'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  @override
  String toJson() {
    return jsonEncode(
      {
        'topic_id': topicId,
        'alias': alias,
        ...?id != null ? {'id': id} : null,
        ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
        ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      },
    );
  }
}
