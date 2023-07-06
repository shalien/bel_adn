import 'dart:convert';

import 'package:bel_adn/src/model/provider_link.dart';

import '../dao/provider_data_access_object.dart';
import '../model.dart';
import 'topic.dart';

class Provider extends Model {
  static ProviderDataAccessObject dao = ProviderDataAccessObject();

  final String? prefix;

  final int topicId;

  Topic? _topic;

  Future<Topic> get topic async {
    _topic ??= await Topic.dao.show(topicId);
    return _topic!;
  }

  final int providerLinkId;

  Future<ProviderLink> get providerLink async =>
      await ProviderLink.dao.show(providerLinkId);

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
