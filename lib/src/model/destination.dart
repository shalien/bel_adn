part of '../model.dart';

/// A file created after a search.
@immutable
final class Destination extends Model {
  /// The name of the file.
  final String filename;

  final String? sha512;

  /// The medias associated with this destination.
  Future<List<Media>?> get medias async =>
      await _client?.medias.showByDestinationId(this);

  /// The searches associated with this destination.
  const Destination(this.filename, this.sha512) : super();

  @override
  const Destination._internal(super.id, super.createdAt, super.updatedAt,
      super.deletedAt, this.filename, this.sha512, super.client)
      : super._internal();

  /// Creates a destination from a JSON object.
  Destination.fromJson(super.json, super.client)
      : filename = json['filename'],
  sha512 = json['sha512'],
        super.fromJson();

  @override
  String toJson() {
    return jsonEncode({
      'filename': filename,
      'sha512': sha512,
      ...jsonDecode(super.toJson()),
    });
  }

  @override
  Destination copyWith({String? filename, String? sha512}) {
    return Destination._internal(id, createdAt, updatedAt, deletedAt,
        filename ?? this.filename, sha512 ?? this.sha512, _client);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Destination &&
            runtimeType == other.runtimeType &&
            filename == other.filename &&
            sha512 == other.sha512 &&
            super == (other);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      filename.hashCode ^
      sha512.hashCode ^
      deletedAt.hashCode ^
      super.hashCode;
}
