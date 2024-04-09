part of '../data_access_object.dart';

@immutable
final class ProviderTypeDataAccessObject
    extends DataAccessObject<ProviderType> {
  const ProviderTypeDataAccessObject(MagnifiqueCoupleClient client, Uri baseUri)
      : super(endpoint: 'provider_types', client: client, baseUri: baseUri);

  @override
  ProviderType fromJson(Map<String, dynamic> json) {
    return ProviderType.fromJson(json, client);
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
      models = json
          .map((dynamic model) => Supplier.fromJson(model, client))
          .toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<List<ProviderType>> index() {
    // TODO: implement index
    throw UnimplementedError();
  }
}
