import 'dart:convert';

import '../dao/provider_type_data_access_object.dart';
import '../model.dart';

class ProviderType extends Model {
  static ProviderTypeDataAccessObject dao = ProviderTypeDataAccessObject();

  final String name;

  ProviderType(this.name, {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory ProviderType.fromJson(Map<String, dynamic> json) {
    return ProviderType(
      json['name'],
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
