import 'dart:convert';

import '../model.dart';

final class User extends Model {
  final int snowflake;

  final String name;

  User({
    required this.snowflake,
    required this.name,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  factory User.fromJson(Map json) {
    return User(
      snowflake: json['snowflake'],
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
        'snowflake': snowflake,
        'name': name,
      },
    );
  }
}
