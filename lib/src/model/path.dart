part of '../model.dart';

/// The query part of the search
final class Path extends Model {
  /// The content of the path.
  final String content;

  /// The searches associated with this path.
  Future<List<Search>?> get searches async =>
      await _client?.paths.searches(this);

  const Path(this.content) : super();

  Path.fromJson(super.json, {super.client})
      : content = json['content'],
        super.fromJson();

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'content': content,
    });
  }

  @override
  Model copyWith({String? content}) {
    return Path(
      content ?? this.content,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Path &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt &&
            content == other.content;
  }

  @override
  int get hashCode =>
      id.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ content.hashCode;
}
