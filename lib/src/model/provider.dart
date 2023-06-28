import 'dart:convert';

import '../dao/provider_data_access_object.dart';
import '../dao/provider_type_data_access_object.dart';
import '../dao/topic_data_access_object.dart';
import '../model.dart';
import 'provider_type.dart';
import 'topic.dart';

class Provider extends Model {
  static ProviderDataAccessObject dao = ProviderDataAccessObject();

  final int? topicId;

  final int providerTypeId;

  final String link;

  final String? prefix;

  Future<Topic> get topic async => await TopicDataAccessObject().show(topicId!);

  Future<ProviderType> get providerType async =>
      await ProviderTypeDataAccessObject().show(providerTypeId);

  Provider(
    this.topicId,
    this.providerTypeId,
    this.link, {
    this.prefix,
    id,
    createdAt,
    updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Provider.fromJson(Map json) {
    return Provider(
      json['topic_id'],
      json['provider_type_id'],
      json['link'],
      prefix: json['prefix'],
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
      'provider_type_id': providerTypeId,
      'link': link,
    });
  }
}
