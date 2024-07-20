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

  @override
  Future<List<Supplier>> index(
      {String? host, int? providerTypeId, int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (host != null) 'host': host,
      if (providerTypeId != null) 'provider_type_id': providerTypeId.toString(),
      if (page != null) 'page': page.toString(),
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

  @override
  Future<Supplier> update(int id, {String? host, int? providerTypeId}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri,
          body: jsonEncode({
            if (host != null) 'host': host,
            if (providerTypeId != null)
              'provider_type_id': providerTypeId.toString(),
          }),
          headers: {
            'Content-Type': 'application/json',
          });
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      final Supplier model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<Supplier> store({host, providerTypeId}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri,
          body: jsonEncode({
            'host': host,
            'provider_type_id': providerTypeId.toString(),
          }),
          headers: {
            'Content-Type': 'application/json',
          });
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body)['data'];
      final Supplier model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }
}
