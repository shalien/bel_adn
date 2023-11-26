part of '../data_access_object.dart';

final class SupplierDataAccessObject extends DataAccessObject<Supplier> {
  const SupplierDataAccessObject(MagnifiqueCoupleClient client)
      : super('suppliers', client);

  @override
  Supplier fromJson(Map<String, dynamic> json) {
    return Supplier.fromJson(json);
  }

  Future<ProviderType> providerType(Supplier supplier) async {
    final Uri uri = Uri.https(
        MagnifiqueCoupleClient.host, '/api/suppliers/${supplier.id}/provider_type');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    ProviderType model;

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      model = ProviderType.fromJson(json);
    } else {
      throw MagnifiqueException(response);
    }

    return model;
  }

}
