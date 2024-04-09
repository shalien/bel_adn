part of '../data_access_object.dart';

@immutable
final class SourceDataAccessObject extends DataAccessObject<Source> {
  const SourceDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'sources');

  Future<Set<Media>> showWithMedia(Source source) async {
    Uri uri = fromParsedHost('/api/$endpoint/${source.id}/medias');

    var response = await client.get(uri);

    if (response.statusCode != 200) {
      throw MagnifiqueException(response);
    }

    Set<Media> medias = {};

    var decodedResponse = jsonDecode(response.body);

    if (decodedResponse['data'] == null) {
      return medias;
    }

    for (var media in decodedResponse['data']) {
      medias.add(Media.fromJson(media));
    }

    return medias;
  }

  Future<Source?> showByLink(Uri link) async {
    if (link.toString().isEmpty) {
      throw ArgumentError("uri cannot be empty");
    }

    Uri uri = fromParsedHost(
        '/api/$endpoint/link/${base64Encode(link.toString().codeUnits)}');

    var response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        Source source = fromJson(json['data']);

        return Future.value(source);
      case 404:
        return null;
      default:
        throw MagnifiqueException(response);
    }
  }

  Future<Source?> showByDestination(String filename) async {
    if (filename.isEmpty) {
      throw ArgumentError("Filename cannot be empty");
    }

    Uri uri = fromParsedHost('/api/destinations/filename/$filename');

    var response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        Source source = fromJson(json['data']);

        return Future.value(source);
      default:
        throw MagnifiqueException(response);
    }
  }

  @override
  Source fromJson(Map<String, dynamic> json) {
    return Source.fromJson(json);
  }

  @override
  Future<List<Source>> index(
      {String? link,
      int? pathId,
      int? topicId,
      int? supplierId,
      int? searchid}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (link != null) 'link': link,
      if (pathId != null) 'path_id': pathId.toString(),
      if (topicId != null) 'topic_id': topicId.toString(),
      if (supplierId != null) 'supplier_id': supplierId.toString(),
      if (searchid != null) 'search_id': searchid.toString(),
    });

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Source> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Source modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
