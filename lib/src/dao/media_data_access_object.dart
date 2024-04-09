part of '../data_access_object.dart';

/// The [DataAccessObject] for the [Media] class
@immutable
final class MediaDataAccessObject extends DataAccessObject<Media> {
  /// The singleton instance for the factory

  @override
  const MediaDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'medias');

  @override
  Media fromJson(Map<String, dynamic> json) {
    return Media.fromJson(json);
  }

  @override
  Future<List<Media>> index(
      {String? link, int? sourceId, String? sha256, int? destinationId}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (link != null) 'link': link,
      if (sourceId != null) 'source_id': sourceId.toString(),
      if (sha256 != null) 'sha256': sha256,
      if (destinationId != null) 'destination_id': destinationId.toString(),
    });

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Media> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Media modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
