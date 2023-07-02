import 'dart:convert';

import 'package:bel_adn/src/model/provider_link.dart';

import '../dao/provider_data_access_object.dart';
import '../model.dart';
import 'topic.dart';

class Provider extends Model {
  static ProviderDataAccessObject dao = ProviderDataAccessObject();

  final String? prefix;

  final int topicId;

  Future<Topic> get topic async => await Topic.dao.show(topicId);

  final List<int> providerLinksIds;

  Future<List<ProviderLink>> get providerLinks async => providerLinksIds
      .map((e) async => await ProviderLink.dao.show(e))
      .toList()
      .cast<ProviderLink>();

  Provider({
    required this.topicId,
    required this.prefix,
    required this.providerLinksIds,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Provider.fromJson(Map json) {
    List<int> providerLinks = json['provider_links'] == null
        ? []
        : (json['provider_links'] as List)
            .map((e) => ProviderLink.fromJson(e).id!)
            .toList();

    return Provider(
      topicId: json['topic_id'],
      prefix: json['prefix'],
      providerLinksIds: providerLinks,
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
      'provider_links': providerLinksIds,
    });
  }
}
