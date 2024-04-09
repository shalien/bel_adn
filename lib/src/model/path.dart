part of '../model.dart';

/// The query part of the search
@immutable
final class Path extends Model {
  /// The content of the path.
  final String content;

  const Path(
      {required this.content,
      super.id,
      super.createdAt,
      super.deletedAt,
      super.updatedAt});

  @override
  Path.fromJson(super.json)
      : content = json['content'],
        super.fromJson();

  @override
  String toJson() {
    return jsonEncode({
      ...jsonDecode(super.toJson()),
      'content': content,
    });
  }

  @override
  Path copyWith({String? content}) {
    return Path(
      content: content ?? this.content,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Path &&
            runtimeType == other.runtimeType &&
            content == other.content &&
            super == (other);
  }

  @override
  int get hashCode => content.hashCode ^ super.hashCode;
}
