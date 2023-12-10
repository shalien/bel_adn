part of '../model.dart';

final class Destination extends Model {
  final String filename;

  const Destination(this.filename) : super();

  Destination.fromJson(super.json, {super.client})
      : filename = json['filename'],
        super.fromJson();

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
  Model copyWith({String? filename}) {
    return Destination(
      filename ?? this.filename,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Destination &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt &&
            filename == other.filename;
  }

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ filename.hashCode;
}
