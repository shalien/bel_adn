import 'dart:convert';

import 'package:bel_adn/src/model/provider_link.dart';

import '../dao/provider_data_access_object.dart';
import '../dao/topic_data_access_object.dart';
import '../model.dart';
import 'topic.dart';

class Provider extends Model {
  static ProviderDataAccessObject dao = ProviderDataAccessObject();

  final String? prefix;

  final Topic topic;

  final List<ProviderLink> providerLinks;

  Provider({
    required this.topic,
    required this.prefix,
    required this.providerLinks,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Provider.fromJson(Map json) {
    List<ProviderLink>? providerLinks = json['provider_links'] == null
        ? []
        : (json['provider_links'] as List)
            .map((e) => ProviderLink.fromJson(e))
            .toList();

    return Provider(
      topic: Topic.fromJson(json['topic']),
      prefix: json['prefix'],
      providerLinks: providerLinks,
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
      'topic_id': topic.id,
      ...?prefix != null ? {'prefix': prefix} : null,
      'provider_links': providerLinks.map((e) => e.toJson()).toList(),
    });
  }
}
