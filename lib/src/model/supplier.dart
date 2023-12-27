part of '../model.dart';

@immutable
final class Supplier extends Model {
  final String host;

  final int providerTypeId;

  Future<ProviderType?> get providerType async =>
      await _client?.providerTypes.show(providerTypeId);

  Future<List<Search>?> get searches async =>
      await _client?.suppliers.searches(this);

  const Supplier(this.host, this.providerTypeId) : super();

  const Supplier._internal(super.id, super.createdAt, super.updatedAt,
      super.deletedAt, this.host, this.providerTypeId, super.client)
      : super._internal();

  Supplier.fromJson(super.json, super.client)
      : host = json['host'],
        providerTypeId = json['provider_type_id'],
        super.fromJson();

  @override
  Supplier copyWith({String? host, int? providerTypeId}) {
    return Supplier._internal(id, createdAt, updatedAt, deletedAt,
        host ?? this.host, providerTypeId ?? this.providerTypeId, _client);
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
