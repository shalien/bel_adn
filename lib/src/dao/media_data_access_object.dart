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
      {Uri? link,
      int? sourceId,
      String? sha256,
      int? destinationId,
      int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (link != null) 'link': link.toString(),
      if (sourceId != null) 'source_id': sourceId.toString(),
      if (sha256 != null) 'sha256': sha256,
      if (destinationId != null) 'destination_id': destinationId.toString(),
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

  @override
  Future<Media> update(int id,
      {Uri? link, int? sourceId, String? sha256}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri,
          body: jsonEncode({
            if (link != null) 'link': link.toString(),
            if (sourceId != null) 'source_id': sourceId.toString(),
            if (sha256 != null) 'sha256': sha256,
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
      final dynamic json = jsonDecode(response.body)['data'];
      final Media model = fromJson(json);

      return model;
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<Media> store({link, sourceId, sha256}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri,
          body: jsonEncode({
            'link': link.toString(),
            'source_id': sourceId.toString(),
            'sha256': sha256,
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
      final dynamic json = jsonDecode(response.body)['data'];
      return fromJson(json);
    } else {
      throw MagnifiqueException(response);
    }
  }
}
