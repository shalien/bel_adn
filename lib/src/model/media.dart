part of '../model.dart';

/// Represent a [Media]
///
/// The media will posted on discord
@immutable
final class Media extends Model {
  /// The link of the media
  final Uri link;

  /// The source of the media
  final int? sourceId;

  /// The destination of the media
  final int? destinationId;

  /// The sha256 of the media
  final String? sha256;

  /// A [Media] will be composed during all the resolving process
  const Media(
      {required this.link,
      this.sourceId,
      required this.sha256,
        this.destinationId,
      required super.id,
      required super.createdAt,
      required super.updatedAt,
      super.deletedAt});

  /// Create a [Media] from a json
  Media.fromJson(super.json)
      : link = Uri.parse(json['link']),
        sourceId = int.tryParse(json['source_id'].toString()),
        sha256 = json['sha256'],
        destinationId = int.tryParse(json['destination_id'].toString()),
        super.fromJson();

  /// Convert a media to a json string
  @override
  String toJson() {
    return jsonEncode({
      ...jsonDecode(super.toJson()),
      'source_id': sourceId,
      'sha256': sha256,
      'destination_id': destinationId,
      'link': link.toString(),
    });
  }

  @override
  Media copyWith({
    Uri? link,
    int? sourceId,
    String? sha256,
    int? destinationId,
  }) {
    return Media(
      link: link ?? this.link,
      sourceId: sourceId ?? this.sourceId,
      sha256: sha256 ?? this.sha256,
      destinationId: destinationId ?? this.destinationId,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Media &&
            runtimeType == other.runtimeType &&
            super == (other) &&
            link == other.link &&
            sourceId == other.sourceId &&
            sha256 == other.sha256 &&
            destinationId == other.destinationId;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      link.hashCode ^
      sourceId.hashCode ^
      sha256.hashCode ^
      destinationId.hashCode;
}
