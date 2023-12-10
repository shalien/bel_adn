part of '../data_access_object.dart';

final class ProviderTypeDataAccessObject
    extends DataAccessObject<ProviderType> {
  const ProviderTypeDataAccessObject(MagnifiqueCoupleClient client)
      : super('provider_types', client);

  @override
  ProviderType fromJson(Map<String, dynamic> json) {
    return ProviderType.fromJson(json);
  }

  Future<List<Supplier>> suppliers(ProviderType providerType) async {
    final Uri uri =
        Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/${providerType.id}/suppliers');

    Response response;

    try {
      response = await _client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Supplier> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) => Supplier.fromJson(model, client: _client)).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }



}
