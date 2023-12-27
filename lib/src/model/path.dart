part of '../model.dart';

/// The query part of the search
@immutable
final class Path extends Model {
  /// The content of the path.
  final String content;

  /// The searches associated with this path.
  Future<List<Search>?> get searches async =>
      await _client?.paths.searches(this);

  const Path(this.content) : super();

  @override
  const Path._internal(super.id, super.createdAt, super.updatedAt,
      super.deletedAt, this.content, super.client)
      : super._internal();

  Path.fromJson(super.json, super.client)
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
    return Path._internal(
        id, createdAt, updatedAt, deletedAt, content ?? this.content, _client);
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
