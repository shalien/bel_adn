import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';

final class ProhibitedDomain extends Model {
  final String domain;

  ProhibitedDomain({
    required this.domain,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  ProhibitedDomain.fromJson(Map json)
      : domain = json['domain'],
        super(
          id: json['id'],
          createdAt: json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
          updatedAt: json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
        );

  @override
  String toJson() {
    return jsonEncode(
      {
        ...?id != null ? {'id': id} : null,
        ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
        ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
        'domain': domain,
      },
    );
  }
}
