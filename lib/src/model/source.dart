import 'dart:convert';

import '../dao/provider_data_access_object.dart';
import '../dao/source_data_access_object.dart';
import '../model.dart';
import 'provider.dart';

class Source extends Model {
  static SourceDataAccessObject dao = SourceDataAccessObject();

  final Uri link;

  final int providerId;

  Future<Provider> get provider async => await Provider.dao.show(providerId);

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
