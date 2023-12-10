part of '../model.dart';

final class Supplier extends Model {
  final String host;

  final int providerTypeId;

  const Supplier(this.host, this.providerTypeId) : super();

  Supplier.fromJson(super.json, {super.client})
      : host = json['host'],
        providerTypeId = json['provider_type_id'],
        super.fromJson();

  @override
  Supplier copyWith({String? host, int? providerTypeId}) {
    return Supplier(host ?? this.host,  providerTypeId ?? this.providerTypeId);
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'host': host,
    });
  }
}
