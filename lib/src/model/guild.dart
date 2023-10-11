import 'dart:convert';

import '../model.dart';

final class Guild extends Model {
  final int? snowflake;

  final String name;

  final String? icon;

  Guild({
    required this.snowflake,
    required this.name,
    this.icon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: snowflake, createdAt: createdAt, updatedAt: updatedAt);

  factory Guild.fromJson(Map json) {
    return Guild(
      snowflake: json['snowflake'],
      name: json['name'],
      icon: json['icon'],
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
        ...?icon != null ? {'icon': icon} : null,
        ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
        ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
        'snowflake': snowflake,
        'name': name,
      },
    );
  }
}
