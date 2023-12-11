part of '../model.dart';

/// A file created after a search.
final class Destination extends Model {
  /// The name of the file.
  final String filename;

  /// The medias associated with this destination.
  Future<List<Media>?> get medias async =>
      await _client?.medias.showByDestinationId(this);

  /// The searches associated with this destination.
  const Destination(this.filename) : super();

  /// Creates a destination from a JSON object.
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
  int get hashCode =>
      id.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ filename.hashCode;
}
