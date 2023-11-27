part of '../data_access_object.dart';

final class SupplierDataAccessObject extends DataAccessObject<Supplier> {
  const SupplierDataAccessObject(MagnifiqueCoupleClient client)
      : super('suppliers', client);

  @override
  Supplier fromJson(Map<String, dynamic> json) {
    return Supplier.fromJson(json);
  }

  Future<ProviderType> providerType(Supplier supplier) async {

    var providerType = await _client.providerTypes.show(supplier.providerTypeId);

    return providerType;

  }

}
