import 'dart:convert';

import '../cache/cache.dart';
import '../dao/unmanaged_reddit_host_data_access_object.dart';
import '../utils.dart';
import 'model.dart';

Cache<UnmanagedRedditHost> get _cache => Cache();

class UnmanagedRedditHost extends Model {
  static UnmanagedRedditHostDataAccessObject dao =
      UnmanagedRedditHostDataAccessObject(baseUri);

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

    if (json['id'] != null) {
      unmanagedRedditHost = _cache.get(json['id']);
    }

    if (unmanagedRedditHost == null) {
      unmanagedRedditHost = UnmanagedRedditHost(
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

      _cache.add(unmanagedRedditHost);
    }

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
