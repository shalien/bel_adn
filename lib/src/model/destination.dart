part of '../model.dart';

/// A file created after a search.
@immutable
final class Destination extends Model {
  /// The name of the file.
  final String filename;

  /// The medias associated with this destination.
  Future<List<Media>?> get medias async =>
      await _client?.medias.showByDestinationId(this);

  /// The searches associated with this destination.
  const Destination(this.filename) : super();

  @override
  const Destination._internal(super.id, super.createdAt, super.updatedAt,
      super.deletedAt, this.filename, super.client)
      : super._internal();

  /// Creates a destination from a JSON object.
  Destination.fromJson(super.json, super.client)
      : filename = json['filename'],
        super.fromJson();

  @override
  String toJson() {
    return jsonEncode({
      'filename': filename,
      ...jsonDecode(super.toJson()),
    });
  }

  @override
  Destination copyWith({String? filename}) {
    return Destination._internal(id, createdAt, updatedAt, deletedAt,
        filename ?? this.filename, _client);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Destination &&
            runtimeType == other.runtimeType &&
            filename == other.filename &&
            super == (other);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      filename.hashCode ^
      deletedAt.hashCode ^
      super.hashCode;
}
