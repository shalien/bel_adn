part of '../model.dart';

/// A file created after a search.
@immutable
final class Destination extends Model {
  /// The name of the file.
  final String filename;

  /// The SHA-256 hash of the file.
  final String? sha256;

  /// The searches associated with this destination.
  const Destination({
    required this.filename,
    required this.sha256,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  /// Creates a destination from a JSON object.
  Destination.fromJson(super.json)
      : filename = json['filename'],
        sha256 = json['sha256'],
        super.fromJson();

  @override
  String toJson() {
    return jsonEncode({
      'filename': filename,
      'sha256': sha256,
      ...jsonDecode(super.toJson()),
    });
  }

  @override
  Destination copyWith({String? filename, String? sha256}) {
    return Destination(
      filename: filename ?? this.filename,
      sha256: sha256 ?? this.sha256,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Destination &&
            runtimeType == other.runtimeType &&
            filename == other.filename &&
            sha256 == other.sha256 &&
            super == (other);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      filename.hashCode ^
      sha256.hashCode ^
      deletedAt.hashCode ^
      super.hashCode;
}
