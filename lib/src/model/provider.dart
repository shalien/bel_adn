import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';

final class Provider extends Model {
  final String? prefix;

  final int? topicId;

  final int providerLinkId;

  Provider({
    required this.topicId,
    required this.prefix,
    required this.providerLinkId,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Provider.fromJson(Map json) {
    return Provider(
      topicId: json['topic_id'],
      prefix: json['prefix'],
      providerLinkId: json['provider_link_id'],
      id: json['id'],
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
    return json.encode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'topic_id': topicId,
      ...?prefix != null ? {'prefix': prefix} : null,
      'provider_link_id': providerLinkId,
    });
  }
}
