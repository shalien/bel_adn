import 'dart:convert';

import 'package:bel_adn/src/model/provider_link.dart';

import '../dao/provider_data_access_object.dart';
import '../dao/topic_data_access_object.dart';
import '../model.dart';
import 'topic.dart';

class Provider extends Model {
  static ProviderDataAccessObject dao = ProviderDataAccessObject();

  final int? topicId;

  final String? prefix;

  final List<int>? providerLinks;

  Future<Topic> get topic async => await TopicDataAccessObject().show(topicId!);

  Future<List<ProviderLink>> get providerLinksList async {
    List<ProviderLink> list = [];
    for (int id in providerLinks!) {
      list.add(await ProviderLink.dao.show(id));
    }
    return list;
  }

  Provider({
    required this.topicId,
    required this.prefix,
    required this.providerLinks,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Provider.fromJson(Map json) {
    List<int>? providerLinks = json['provider_links'] == null
        ? []
        : (json['provider_links'] as List)
            .map((e) => ProviderLink.fromJson(e).id!)
            .toList();

    return Provider(
      topicId: json['topic_id'],
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
      ...?topicId != null ? {'topic_id': topicId} : null,
      ...?prefix != null ? {'prefix': prefix} : null,
      ...?providerLinks != null ? {'providerlinks': providerLinks} : null,
    });
  }
}
