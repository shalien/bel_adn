part of '../model.dart';

@immutable
final class Source extends Model {
  final Uri link;

  final int? pathId;

  final int? topicId;

  final int? supplierId;

  final int? searchId;

  const Source({
    required this.link,
    this.pathId,
    this.topicId,
    this.supplierId,
    this.searchId,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  Source.fromJson(super.json)
      : link = Uri.parse(json['link']),
  pathId = json['path_id'],
  topicId = json['topic_id'],
  supplierId = json['supplier_id'],
  searchId = json['search_id'],
        super.fromJson();

  @override
  Source copyWith(
      {Uri? link, int? pathId, int? topicId, int? supplierId, int? searchId}) {
    return Source(
      link: link ?? this.link,
      pathId: pathId ?? this.pathId,
      topicId: topicId ?? this.topicId,
      supplierId: supplierId ?? this.supplierId,
      searchId: searchId ?? this.searchId,
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
      'link': link.toString(),
      'path_id': pathId,
      'topic_id': topicId,
      'supplier_id': supplierId,
      'search_id': searchId
    });
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Source &&
            runtimeType == other.runtimeType &&
            super == (other) &&
            link == other.link &&
            pathId == other.pathId &&
            topicId == other.topicId &&
            supplierId == other.supplierId &&
            searchId == other.searchId;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      link.hashCode ^
      searchId.hashCode ^
      supplierId.hashCode ^
      topicId.hashCode ^
      pathId.hashCode;
}
