part of '../data_access_object.dart';

@immutable
final class SupplierDataAccessObject extends DataAccessObject<Supplier> {
  const SupplierDataAccessObject(
      {required super.client, required super.baseUri})
      : super(endpoint: 'suppliers');

  @override
  Supplier fromJson(Map<String, dynamic> json) {
    return Supplier.fromJson(json);
  }

  Future<ProviderType> providerType(Supplier supplier) async {
    var providerType = await client.providerTypes.show(supplier.providerTypeId);

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
      models = json.map((dynamic model) => Search.fromJson(model)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<List<Supplier>> index({String? host, int? providerTypeId}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (host != null) 'host': host,
      if (providerTypeId != null) 'provider_type_id': providerTypeId.toString(),
    });

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Supplier> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Supplier modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
