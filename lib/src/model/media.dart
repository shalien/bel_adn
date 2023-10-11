import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';

/// Represent a [Media]
///
/// The media will posted on discord
class Media extends Model {
  final Uri link;

  final int sourceId;

  final int destinationId;

  /// A [Media] will be composed during all the resolving process
  Media(
      {required this.sourceId,
      required this.link,
      required this.destinationId,
      int? id,
      DateTime? createdAt,
      DateTime? updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  /// Create [Media] from a json string
  @override
  factory Media.fromJson(Map json) {
    return Media(
      link: Uri.parse(json['link']),
      sourceId: json['source_id'],
      destinationId: json['destination_id'],
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  /// Convert a media to a json string
  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'source_id': sourceId,
      'destination_id': destinationId,
      'link': link.toString(),
    });
  }
}
