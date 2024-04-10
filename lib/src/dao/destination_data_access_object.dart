part of '../data_access_object.dart';

@immutable
final class DestinationDataAccessObject extends DataAccessObject<Destination> {
  @override
  const DestinationDataAccessObject(
      {required super.client, required super.baseUri})
      : super(endpoint: 'destinations');

  @override
  Destination fromJson(Map<String, dynamic> json) {
    return Destination.fromJson(json);
  }

  @override
  Future<List<Destination>> index({String? filename, String? sha256, int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (filename != null) 'filename': filename,
      if (sha256 != null) 'sha256': sha256,
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

    List<Destination> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Destination modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
