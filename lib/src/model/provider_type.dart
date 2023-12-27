part of '../model.dart';

@immutable
final class ProviderType extends Model {
  final String name;

  const ProviderType(this.name) : super();

  const ProviderType._internal(super.id, super.createdAt, super.updatedAt,
      super.deletedAt, this.name, super.client)
      : super._internal();

  ProviderType.fromJson(super.json, super.client)
      : name = json['name'],
        super.fromJson();

  @override
  ProviderType copyWith({String? name}) {
    return ProviderType._internal(
        id, createdAt, updatedAt, deletedAt, name ?? this.name, _client);
  }

  @override
  String toJson() {
    return jsonEncode({
      ...jsonDecode(super.toJson()),
      'name': name,
    });
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProviderType &&
            runtimeType == other.runtimeType &&
            super == (other) &&
            name == other.name;
  }

  @override
  int get hashCode => super.hashCode ^ name.hashCode;
}
