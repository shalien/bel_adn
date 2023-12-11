part of '../model.dart';

final class Search extends Model {
  final int? topicId;

  Future<Topic?> get topic async => await _client?.topics.show(topicId!);

  final int? pathId;

  Future<Path?> get path async => await _client?.paths.show(pathId!);

  final int? supplierId;

  Future<Supplier?> get supplier async =>
      await _client?.suppliers.show(supplierId!);

  const Search(this.topicId, this.pathId, this.supplierId) : super();

  Search.fromJson(super.json, {super.client})
      : topicId = json['topic_id'],
        pathId = json['path_id'],
        supplierId = json['supplier_id'],
        super.fromJson();

  @override
  Model copyWith({int? topicId, int? pathId, int? supplierId}) {
    return Search(
      topicId ?? this.topicId,
      pathId ?? this.pathId,
      supplierId ?? this.supplierId,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
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
