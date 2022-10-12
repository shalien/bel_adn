import 'dart:convert';

import '../model.dart';

/// Represent a [Media]
///
/// The media will posted on discord
class Media extends Model {
  /// [Media] [Provider] id
  final int? _providerId;
  int? get providerId => _providerId;

  /// The [Media] source
  String? source;

  /// The [Media] media, that will be downloaded
  String? media;

  /// An intermediate source for some [Provider]
  String? intermediateSource;

  /// The name of the [Media]
  String? destination;

  /// A [Media] will be composed during all the resolving process
  Media(
      [this._providerId,
      this.source,
      this.media,
      this.destination,
      id,
      createdAt,
      updatedAt])
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  /// Create [Media] from a json string
  Media.fromJson(Map json)
      : _providerId = json['provider_id'],
        source = json['source'],
        media = json['media'],
        destination = json['destination'],
        super.fromJson(json);

  /// Convert a media to a json string
  @override
  String toJson() {
    return json.encode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt} : null,
      ...?_providerId != null ? {'provider_id': _providerId} : null,
      ...?source != null ? {'source': source} : null,
      ...?media != null ? {'media': media} : null,
      ...?destination != null ? {'destination': destination} : null
    });
  }
}
