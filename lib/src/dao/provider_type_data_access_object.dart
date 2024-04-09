part of '../data_access_object.dart';

@immutable
final class ProviderTypeDataAccessObject
    extends DataAccessObject<ProviderType> {
  const ProviderTypeDataAccessObject(
      {required super.client, required super.baseUri})
      : super(endpoint: 'provider_types');

  @override
  ProviderType fromJson(Map<String, dynamic> json) {
    return ProviderType.fromJson(json);
  }

  Future<List<Supplier>> suppliers(ProviderType providerType) async {
    final Uri uri =
        fromParsedHost('/api/$endpoint/${providerType.id}/suppliers');

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
      models = json.map((dynamic model) => Supplier.fromJson(model)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<List<ProviderType>> index({String? name}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (name != null) 'name': name,
    });

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<ProviderType> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        ProviderType modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
