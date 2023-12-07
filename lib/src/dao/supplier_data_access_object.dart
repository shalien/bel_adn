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

  Future<List<Path>> paths(Supplier supplier) async {
    final Uri uri =
    Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/${supplier.id}/paths');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Path> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) => Path.fromJson(model)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;


  }

}
