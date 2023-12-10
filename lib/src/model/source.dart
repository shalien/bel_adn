part of '../model.dart';

final class Source extends Model {
  final Uri link;

  final int? pathId;

  const Source(this.link, this.pathId) : super();

  Source.fromJson(super.json, {super.client})
      : link = Uri.parse(json['link']),
        pathId = json['path_id'],
        super.fromJson();

  @override
  Model copyWith({Uri? link, int? pathId}) {
    return Source(
      link ?? this.link,
      pathId ?? this.pathId,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'link': link.toString(),
      'path_id': pathId
    });
  }
}
