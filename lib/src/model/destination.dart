import 'dart:convert';

import '../dao/destination_data_access_object.dart';
import '../model.dart';

class Destination extends Model {
  static DestinationDataAccessObject dao = DestinationDataAccessObject();

  final String filename;

  Destination(this.filename, {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  factory Destination.fromJson(Map json) {
    return Destination(
      json['filename'],
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
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
