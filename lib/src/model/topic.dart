part of '../model.dart';

@immutable
final class Topic extends Model {
  final String name;

  final int order;

  const Topic({
    required this.name,
    required this.order,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  Topic.fromJson(super.json)
      : name = json['name'],
        order = json['order'],
        super.fromJson();

  @override
  Topic copyWith({String? name, int? order}) {
    return Topic(
      name: name ?? this.name,
      order: order ?? this.order,
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
