part of '../data_access_object.dart';

@immutable
final class SupplierDataAccessObject extends DataAccessObject<Supplier> {
  const SupplierDataAccessObject(MagnifiqueCoupleClient client, Uri baseUri)
      : super(endpoint: 'suppliers', client: client, baseUri: baseUri);

  @override
  Supplier fromJson(Map<String, dynamic> json) {
    return Supplier.fromJson(json, client);
  }

  Future<ProviderType> providerType(Supplier supplier) async {
    var providerType =
        await client.providerTypes.show(supplier.providerTypeId);

    return providerType;
  }

  Future<List<Search>> searches(Supplier supplier) async {
    final Uri uri = fromParsedHost('/api/$endpoint/${supplier.id}/searches');

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Search> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models =
          json.map((dynamic model) => Search.fromJson(model, client)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<List<Supplier>> index() {
    // TODO: implement index
    throw UnimplementedError();
  }
}
