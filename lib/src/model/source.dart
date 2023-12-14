part of '../model.dart';

final class Source extends Model {
  final Uri link;

  final int? searchId;

  const Source(this.link, this.searchId) : super();

  Source.fromJson(super.json, {super.client})
      : link = Uri.parse(json['link']),
        searchId = json['search_id'],
        super.fromJson();

  @override
  Model copyWith({Uri? link, int? searchId}) {
    return Source(
      link ?? this.link,
      searchId ?? this.searchId,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'link': link.toString(),
      'search_id': searchId
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
            searchId == other.searchId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      link.hashCode ^
      searchId.hashCode;
}
