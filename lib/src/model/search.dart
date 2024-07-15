part of '../model.dart';

@immutable
final class Search extends Model {
  final int topicId;

  final int pathId;

  final int supplierId;

  const Search({
    required this.topicId,
    required this.pathId,
    required this.supplierId,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  @override
  Search.fromJson(super.json)
      : topicId = json['topic_id'],
        pathId = json['path_id'],
        supplierId = json['supplier_id'],
        super.fromJson();

  @override
  Search copyWith({int? topicId, int? pathId, int? supplierId}) {
    return Search(
      topicId: topicId ?? this.topicId,
      pathId: pathId ?? this.pathId,
      supplierId: supplierId ?? this.supplierId,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...jsonDecode(super.toJson()),
      'topic_id': topicId,
      'path_id': pathId,
      'supplier_id': supplierId
    });
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Search &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt &&
            topicId == other.topicId &&
            pathId == other.pathId &&
            supplierId == other.supplierId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      topicId.hashCode ^
      pathId.hashCode ^
      supplierId.hashCode;
}
