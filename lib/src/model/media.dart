part of '../model.dart';

/// Represent a [Media]
///
/// The media will posted on discord
final class Media extends Model {
  final Uri link;

  final int sourceId;

  final int destinationId;

  /// A [Media] will be composed during all the resolving process
  const Media(this.link, this.sourceId, this.destinationId) : super();

  /// Create a [Media] from a json
  Media.fromJson(super.json, {super.client})
      : link = Uri.parse(json['link']),
        sourceId = json['source_id'],
        destinationId = json['destination_id'],
        super.fromJson();

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

  @override
  Model copyWith({
    Uri? link,
    int? sourceId,
    int? destinationId,
  }) {
    return Media(
      link ?? this.link,
      sourceId ?? this.sourceId,
      destinationId ?? this.destinationId,
    );
  }
}
