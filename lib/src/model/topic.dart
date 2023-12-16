part of '../model.dart';

@immutable
final class Topic extends Model {
  final String name;

  final int order;

  Future<List<Search>?> get searches async =>
      await _client?.topics.searches(this);

  const Topic(this.name, this.order) : super();

  const Topic._internal(super.id, super.createdAt, super.updatedAt,
      super.deletedAt, this.name, this.order, super.client)
      : super._internal();

  Topic.fromJson(super.json, super.client)
      : name = json['name'],
        order = json['order'],
        super.fromJson();

  @override
  Topic copyWith({String? name, int? order}) {
    return Topic._internal(id, createdAt, updatedAt, deletedAt,
        name ?? this.name, order ?? this.order, _client);
  }

  @override
  String toJson() {
    return jsonEncode({
      ...jsonDecode(super.toJson()),
      'name': name,
      'order': order,
    });
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Topic &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            order == other.order &&
            super == (other);
  }

  @override
  int get hashCode => super.hashCode ^ name.hashCode ^ order.hashCode;
}
