part of '../model.dart';

/// Represent a [Media]
///
/// The media will posted on discord
@immutable
final class Media extends Model {
  /// The link of the media
  final Uri link;

  /// The source of the media
  final int sourceId;

  /// The destination of the media
  Future<Source?> get source async => await _client?.sources.show(sourceId);

  /// The destination of the media
  final int destinationId;

  /// The destination of the media
  Future<Destination?> get destination async =>
      await _client?.destinations.show(destinationId);

  /// A [Media] will be composed during all the resolving process
  const Media(this.link, this.sourceId, this.destinationId) : super();

  const Media._internal(this.link, this.sourceId, this.destinationId, super.id,
      super.createdAt, super.updatedAt, super.deletedAt, super.client)
      : super._internal();

  /// Create a [Media] from a json
  Media.fromJson(super.json, super.client)
      : link = Uri.parse(json['link']),
        sourceId = json['source_id'],
        destinationId = json['destination_id'],
        super.fromJson();

  /// Convert a media to a json string
  @override
  String toJson() {
    return jsonEncode({
      ...jsonDecode(super.toJson()),
      'source_id': sourceId,
      'destination_id': destinationId,
      'link': link.toString(),
    });
  }

  @override
  Media copyWith({
    Uri? link,
    int? sourceId,
    int? destinationId,
  }) {
    return Media._internal(
        link ?? this.link,
        sourceId ?? this.sourceId,
        destinationId ?? this.destinationId,
        id,
        createdAt,
        updatedAt,
        deletedAt,
        _client);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Media &&
            runtimeType == other.runtimeType &&
            super == (other) &&
            link == other.link &&
            sourceId == other.sourceId &&
            destinationId == other.destinationId;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      link.hashCode ^
      sourceId.hashCode ^
      destinationId.hashCode;
}
