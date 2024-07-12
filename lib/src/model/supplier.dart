part of '../model.dart';

@immutable
final class Supplier extends Model {
  final String host;

  final int providerTypeId;

  const Supplier({
    required this.host,
    required this.providerTypeId,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  Supplier.fromJson(super.json)
      : host = json['host'],
        providerTypeId = json['provider_type_id'],
        super.fromJson();

  @override
  Supplier copyWith({String? host, int? providerTypeId}) {
    return Supplier(
      host: host ?? this.host,
      providerTypeId: providerTypeId ?? this.providerTypeId,
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
      'host': host,
      'provider_type_id': providerTypeId
    });
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Supplier &&
            runtimeType == other.runtimeType &&
            super == (other) &&
            host == other.host;
  }

  @override
  int get hashCode => super.hashCode ^ host.hashCode ^ providerTypeId.hashCode;
}
