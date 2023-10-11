import 'dart:convert';

import '../model.dart';

final class ProviderType extends Model {
  final String name;

  ProviderType(
      {required this.name, int? id, DateTime? createdAt, DateTime? updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory ProviderType.fromJson(Map<String, dynamic> json) {
    return ProviderType(
      name: json['name'],
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
