part of '../model.dart';

final class Topic extends Model {
  final String name;

  final int order;

  const Topic(this.name, this.order) : super();

  Topic.fromJson(super.json)
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
}
