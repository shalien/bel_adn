part of '../model.dart';

@immutable
final class Source extends Model {
  final Uri link;

  final int? searchId;

  const Source(this.link, this.searchId) : super();

  const Source._internal(super.id, super.createdAt, super.updatedAt,
      super.deletedAt, this.link, this.searchId, super.client)
      : super._internal();

  Source.fromJson(super.json, super.client)
      : link = Uri.parse(json['link']),
        searchId = json['search_id'],
        super.fromJson();

  @override
  Source copyWith({Uri? link, int? searchId}) {
    return Source._internal(id, createdAt, updatedAt, deletedAt,
        link ?? this.link, searchId ?? this.searchId, _client);
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
