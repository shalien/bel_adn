
part of '../model.dart';

final class Search extends Model {

  final int? topicId;

  final int? pathId;

  final int? supplierId;

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



}