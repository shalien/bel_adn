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

  @override
  Future<List<ProviderType>> index({String? name, int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (name != null) 'name': name,
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

  @override
  Future<ProviderType> update(int id, {String? name}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri,
          body: jsonEncode({
            if (name != null) 'name': name,
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
      final ProviderType model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<ProviderType> store({name}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri,
          body: jsonEncode({
            'name': name,
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
      final ProviderType model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }
}
