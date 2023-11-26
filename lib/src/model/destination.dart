
part of '../model.dart';

final class Destination extends Model {
  final String filename;

  const Destination(this.filename) : super();

  Destination.fromJson(super.json) :
        filename = json['filename'], super.fromJson();

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'filename': filename,
    });
  }

  @override
  Model copyWith({
    String? filename
}) {
    return Destination(
      filename ?? this.filename,
    );
  }
}
