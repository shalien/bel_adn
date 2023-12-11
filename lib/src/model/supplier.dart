part of '../model.dart';

final class Supplier extends Model {
  final String host;

  final int providerTypeId;

  Future<ProviderType?> get providerType async =>
      await _client?.providerTypes.show(providerTypeId);

  Future<List<Search>?> get searches async =>
      await _client?.suppliers.searches(this);

  const Supplier(this.host, this.providerTypeId) : super();

  Supplier.fromJson(super.json, {super.client})
      : host = json['host'],
        providerTypeId = json['provider_type_id'],
        super.fromJson();

  @override
  Supplier copyWith({String? host, int? providerTypeId}) {
    return Supplier(host ?? this.host, providerTypeId ?? this.providerTypeId);
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Supplier &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt &&
            host == other.host;
  }

  @override
  int get hashCode =>
      id.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ host.hashCode;
}
