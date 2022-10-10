import 'dart:convert';

import '../model.dart';

class Media extends Model {
  final int? _providerId;
  int? get providerId => _providerId;

  String? source;

  String? media;

  String? intermediateSource;

  String? destination;

  Media(
      [this._providerId,
      this.source,
      this.media,
      this.destination,
      id,
      createdAt,
      updatedAt])
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  Media.fromJson(Map json)
      : _providerId = json['provider_id'],
        source = json['source'],
        media = json['media'],
        destination = json['destination'],
        super.fromJson(json);

  @override
  String toJson() {
    return json.encode({
      ...?id != null ? {'id': id} : null,
      ...?_providerId != null ? {'provider_id': _providerId} : null,
      ...?source != null ? {'source': source} : null,
      ...?media != null ? {'media': media} : null,
      ...?destination != null ? {'destination': destination} : null
    });
  }
}
