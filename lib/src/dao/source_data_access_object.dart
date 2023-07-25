import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';

class SourceDataAccessObject extends DataAccessObject<Source> {
  static SourceDataAccessObject? _sourceAccessObject;

  SourceDataAccessObject._() : super(resource: "sources");

  factory SourceDataAccessObject() {
    return _sourceAccessObject ??= SourceDataAccessObject._();
  }

  Future<Set<Media>> showWithMedia(Source source) async {
    Uri uri = Uri.parse('$resourceUrl/${source.id}/medias');

    var response = await client.get(uri);

    if (response.statusCode != 200) {
      throw response;
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

  Future<Set<Source>> showByProvider(Provider provider) {
    Uri uri = Uri.parse('$resourceUrl/provider/${provider.id}');

    return client.get(uri).then((response) {
      if (response.statusCode != 200) {
        throw response;
      }

      var decodedResponse = jsonDecode(response.body);

      var sources = <Source>{};

      for (var element in decodedResponse['data']) {
        sources.add(Source.fromJson(element));
      }

      return sources;
    });
  }

  Future<Source?> showByLink(Uri link) async {
    if (link.toString().isEmpty) {
      throw ArgumentError("uri cannot be empty");
    }

    if (cache.find((source) => source.link == link).isNotEmpty) {
      return Future.value(cache.find((source) => source.link == link).first);
    }

    Uri uri = Uri.parse(
        '$resourceUrl/link/${base64Encode(link.toString().codeUnits)}');

    var response = await get(uri);

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw ArgumentError("data cannot be null");
        }

        Source source = Source.fromJson(json['data']);
        cache.add(source);
        return Future.value(source);
      case 404:
        return Future.value(null);
      default:
        throw response;
    }
  }
}
