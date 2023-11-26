part of '../data_access_object.dart';


/// The [DataAccessObject] for the [Media] class
@immutable
final class MediaDataAccessObject extends DataAccessObject<Media> {
  /// The singleton instance for the factory


  const MediaDataAccessObject(MagnifiqueCoupleClient client) : super('medias', client);


  Future<Set<Media>> showByDestinationId(Destination destination) async {
    if (destination.id == null) {
      throw ArgumentError("destination id cannot be null");
    }

    Uri uri = Uri.parse('${MagnifiqueCoupleClient.host}/api/destination/${destination.id}');

    var response = await _client.get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        Set<Media> medias = <Media>{};

        for (var source in json['data']) {
          medias.add(Media.fromJson(source));
        }

        return Future.value(medias);
      case 404:
        return Future.value(<Media>{});
      default:
        throw response;
    }
  }

  Future<Set<Media>> showBySourceId(Source source) async {
    if (source.id == null) {
      throw ArgumentError("source id cannot be null");
    }

    Uri uri = Uri.parse('${MagnifiqueCoupleClient.host}/api/source/${source.id}');

    var response = await _client.get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        Set<Media> medias = <Media>{};

        for (var source in json['data']) {
          medias.add(Media.fromJson(source));
        }

        return Future.value(medias);
      case 404:
        return Future.value(<Media>{});
      default:
        throw response;
    }
  }

  Future<Media?> showByLink(Uri link) async {
    if (link.toString().isEmpty) {
      throw ArgumentError("uri cannot be empty");
    }

    Uri uri = Uri.parse('${MagnifiqueCoupleClient.host}/api/link/${base64Encode(link.toString().codeUnits)}');

    var response = await _client.get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        Media source = Media.fromJson(json['data']);
        return Future.value(source);
      case 404:
        return Future.value(null);
      default:
        throw response;
    }
  }


  @override
  Media fromJson(Map<String, dynamic> json) {
    return Media.fromJson(json);
  }
}
