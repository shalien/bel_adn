import 'dart:convert';

import '../cache/cache.dart';
import '../dao/destination_data_access_object.dart';
import '../utils.dart';
import 'model.dart';

Cache<Destination> get _cache => Cache();

class Destination extends Model {
  static DestinationDataAccessObject dao = DestinationDataAccessObject(baseUri);

  final String filename;

  Destination(this.filename, {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Destination.fromJson(Map json) {
    Destination? destination;

    if (json['id'] != null) {
      destination = _cache.get(json['id']);
    }

    if (destination == null) {
      destination = Destination(
        json['filename'],
        id: json['id'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
      );

      _cache.add(destination);
    }

    return destination;
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'filename': filename,
    });
  }
}
