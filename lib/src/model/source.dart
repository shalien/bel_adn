part of '../model.dart';

@immutable
final class Source extends Model {
  final Uri link;

  final int? searchId;

  const Source({
    required this.link,
    required this.searchId,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  Source.fromJson(super.json)
      : link = Uri.parse(json['link']),
        searchId = json['search_id'],
        super.fromJson();

  @override
  Source copyWith({Uri? link, int? searchId}) {
    return Source(
      link: link ?? this.link,
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
            searchId == other.searchId;
  }

  @override
  int get hashCode => super.hashCode ^ link.hashCode ^ searchId.hashCode;
}
