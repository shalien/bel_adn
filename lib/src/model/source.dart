part of '../model.dart';

final class Source extends Model {
  final Uri link;

  final int? topicId;

  final int? pathId;

  final int? supplierId;

  const Source(this.link, this.topicId, this.pathId, this.supplierId) : super();

  Source.fromJson(super.json, {super.client})
      : link = Uri.parse(json['link']),
        pathId = json['path_id'],
        topicId = json['topic_id'],
        supplierId = json['supplier_id'],
        super.fromJson();

  @override
  Model copyWith({Uri? link, int? pathId, int? topicId, int? supplierId}) {
    return Source(
      link ?? this.link,
      pathId ?? this.pathId,
      topicId ?? this.topicId,
      supplierId ?? this.supplierId,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'link': link.toString(),
      'path_id': pathId,
      'topic_id': topicId,
      'supplier_id': supplierId
    });
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Source &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt &&
            link == other.link &&
            pathId == other.pathId &&
            topicId == other.topicId &&
            supplierId == other.supplierId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      link.hashCode ^
      pathId.hashCode ^
      topicId.hashCode ^
      supplierId.hashCode;
}
