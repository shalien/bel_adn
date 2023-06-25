import 'dart:convert';

import '../cache/cache.dart';
import '../dao/destination_data_access_object.dart';
import '../dao/media_data_access_object.dart';
import '../dao/source_data_access_object.dart';
import '../utils.dart';
import 'destination.dart';
import 'model.dart';
import 'source.dart';

Cache<Media> get _cache => Cache();

/// Represent a [Media]
///
/// The media will posted on discord
class Media extends Model {
  static MediaDataAccessObject dao = MediaDataAccessObject(baseUri);

  final String link;

  final int sourceId;

  Future<Source> get source async =>
      await SourceDataAccessObject(baseUri).show(sourceId);

  final int destinationId;

  Future<Destination> get destination async =>
      await DestinationDataAccessObject(baseUri).show(destinationId);

  /// A [Media] will be composed during all the resolving process
  Media(this.sourceId, this.link, this.destinationId,
      {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  Media._(this.link, this.sourceId, this.destinationId,
      {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  /// Create [Media] from a json string
  @override
  factory Media.fromJson(Map json) {
    if (json['id'] != null) {
      final media = _cache.get(json['id']);
      if (media != null) {
        return media;
      }
    }

    final media = Media._(
      json['link'],
      json['source_id'],
      json['destination_id'],
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );

    _cache.add(media);

    return media;
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
      'link': link,
    });
  }
}
