part of '../data_access_object.dart';

/// The [DataAccessObject] for the [Media] class
@immutable
final class MediaDataAccessObject extends DataAccessObject<Media> {
  /// The singleton instance for the factory

  const MediaDataAccessObject(MagnifiqueCoupleClient client)
      : super('medias', client);

  Future<List<Media>> showByDestinationId(Destination destination) async {
    if (destination.id == null) {
      throw ArgumentError("destination id cannot be null");
    }

    Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/destination/${destination.id}');

    var response = await _client.get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        List<Media> medias = <Media>[];

        for (var source in json['data']) {
          medias.add(Media.fromJson(source, client: _client));
        }

        return Future.value(medias);

      default:
        throw MagnifiqueException(response);
    }
  }

  Future<List<Media>> showBySourceId(Source source) async {
    if (source.id == null) {
      throw ArgumentError("source id cannot be null");
    }

    Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/source/${source.id}');

    var response = await _client.get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        List<Media> medias = <Media>[];

        for (var source in json['data']) {
          medias.add(fromJson(source));
        }

        return Future.value(medias);
      default:
        throw MagnifiqueException(response);
    }
  }

  Future<Media?> showByLink(Uri link) async {
    if (link.toString().isEmpty) {
      throw ArgumentError("uri cannot be empty");
    }

    Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/link/${base64Encode(link.toString().codeUnits)}');

    var response = await _client.get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        Media source = fromJson(json['data']);
        return Future.value(source);

        case 404:
        return null;

      default:
        throw MagnifiqueException(response);
    }
  }

  @override
  Media fromJson(Map<String, dynamic> json) {
    return Media.fromJson(json, client: _client);
  }
}
