import 'dart:convert';

import '../cache/cache.dart';
import '../dao/provider_data_access_object.dart';
import '../dao/source_data_access_object.dart';
import '../utils.dart';
import 'model.dart';
import 'provider.dart';

Cache<Source> get _cache => Cache();

class Source extends Model {
  static SourceDataAccessObject dao = SourceDataAccessObject(baseUri);

  final String link;

  final int providerId;

  Future<Provider> get provider async =>
      await ProviderDataAccessObject(baseUri).show(providerId);

  Source(this.link, this.providerId, {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Source.fromJson(Map json) {
    Source? source;

    if (json['id'] != null) {
      source = _cache.get(json['id']);
    }

    if (source == null) {
      source = Source(
        json['link'],
        json['provider_id'],
        id: json['id'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
      );

      _cache.add(source);
    }

    return source;
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'provider_id': providerId,
      'link': link,
    });
  }
}
