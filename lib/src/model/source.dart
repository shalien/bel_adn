import 'dart:convert';

import 'package:bel_adn/src/dao/provider_data_access_object.dart';

import '../model.dart';
import 'provider.dart';

class Source extends Model {
  final Uri link;

  final int? providerId;

  Provider? _provider;

  Future<Provider?> get provider async {
    if (providerId == null) {
      return null;
    }

    return _provider ??= await ProviderDataAccessObject().show(providerId!);
  }

  Source(
      {required this.link,
      required this.providerId,
      int? id,
      DateTime? createdAt,
      DateTime? updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Source.fromJson(Map json) {
    return Source(
      link: Uri.parse(json['link']),
      providerId: json['provider_id'],
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
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'provider_id': providerId,
      'link': link.toString(),
    });
  }
}
