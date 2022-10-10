import 'dart:convert';

import '../dao/model.dart';

class Media extends Model {
  final int? _providerId;
  int? get providerId => _providerId;

  String? source;

  String? media;

  String? intermediateSource;

  String? destination;

  Media([this._providerId, this.source, this.media, this.destination, id])
      : super(id: id);

  factory Media.fromJson(Map json) {
    return Media(json['provider_id'], json['source'], json['media'],
        json['destination'], json['id']);
  }

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
