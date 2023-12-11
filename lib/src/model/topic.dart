part of '../model.dart';

final class Topic extends Model {
  final String name;

  final int order;

  Future<List<Search>?> get searches async =>
      await _client?.topics.searches(this);

  const Topic(this.name, this.order) : super();

  Topic.fromJson(super.json, {super.client})
      : name = json['name'],
        order = json['order'],
        super.fromJson();

  @override
  Model copyWith({String? name, int? order}) {
    return Topic(
      name ?? this.name,
      order ?? this.order,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'name': name,
      'order': order,
    });
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Topic &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt &&
            name == other.name &&
            order == other.order;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      name.hashCode ^
      order.hashCode;
}
