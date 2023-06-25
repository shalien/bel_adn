import 'dart:convert';

import '../cache/cache.dart';
import '../dao/provider_type_data_access_object.dart';
import '../utils.dart';
import 'model.dart';

Cache<ProviderType> get _cache => Cache();

class ProviderType extends Model {
  static ProviderTypeDataAccessObject dao =
      ProviderTypeDataAccessObject(baseUri);

  final String name;

  ProviderType(this.name, {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory ProviderType.fromJson(Map<String, dynamic> json) {
    ProviderType? providerType;

    if (json['id'] != null) {
      providerType = _cache.get(json['id']);
    }

    if (providerType == null) {
      providerType = ProviderType(
        json['name'],
        id: json['id'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
      );

      _cache.add(providerType);
    }

    return providerType;
  }

  @override
  String toJson() {
    return jsonEncode(
      {
        ...?id != null ? {'id': id} : null,
        ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
        ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
        'name': name,
      },
    );
  }
}
