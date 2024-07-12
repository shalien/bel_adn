part of '../model.dart';

@immutable
final class ProviderType extends Model {
  final String name;

  const ProviderType(
      {required this.name,
      required super.id,
      required super.createdAt,
      required super.updatedAt,
      super.deletedAt});

  @override
  ProviderType.fromJson(super.json)
      : name = json['name'],
        super.fromJson();

  @override
  ProviderType copyWith({String? name}) {
    return ProviderType(
      name: name ?? this.name,
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
