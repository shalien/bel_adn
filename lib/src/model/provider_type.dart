part of '../model.dart';

final class ProviderType extends Model {
  final String name;

  const ProviderType(this.name) : super();

  ProviderType.fromJson(super.json, {super.client})
      : name = json['name'],
        super.fromJson();

  @override
  Model copyWith({String? name}) {
    return ProviderType(
      name ?? this.name,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'name': name,
    });
  }
}
