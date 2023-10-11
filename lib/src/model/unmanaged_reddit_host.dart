import 'dart:convert';

import '../model.dart';

final class UnmanagedRedditHost extends Model {
  final String? host;
  final String? url;

  UnmanagedRedditHost(
    this.host,
    this.url, {
    id,
    createdAt,
    updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory UnmanagedRedditHost.fromJson(Map json) {
    UnmanagedRedditHost? unmanagedRedditHost;

    unmanagedRedditHost ??= UnmanagedRedditHost(
      json['host'],
      json['url'],
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );

    return unmanagedRedditHost;
  }

  @override
  String toJson() {
    return jsonEncode(
      {
        ...?id != null ? {'id': id} : null,
        ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
        ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
        'host': host,
        'url': url,
      },
    );
  }
}
