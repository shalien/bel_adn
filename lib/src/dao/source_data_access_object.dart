part of '../data_access_object.dart';

@immutable
final class SourceDataAccessObject extends DataAccessObject<Source> {
  const SourceDataAccessObject(MagnifiqueCoupleClient client, Uri baseUri)
      : super(endpoint: 'sources', client: client, baseUri: baseUri);

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
      medias.add(Media.fromJson(media, client));
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
    return Source.fromJson(json, client);
  }

  @override
  Future<List<Source>> index() {
    // TODO: implement index
    throw UnimplementedError();
  }
}
