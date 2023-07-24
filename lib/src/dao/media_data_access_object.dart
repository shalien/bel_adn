import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';
import 'package:meta/meta.dart';

/// The [DataAccessObject] for the [Media] class
@immutable
class MediaDataAccessObject extends DataAccessObject<Media> {
  /// The singleton instance for the factory
  static MediaDataAccessObject? _mediaDataAccessObject;

  /// Private constructor
  MediaDataAccessObject._() : super(resource: "medias");

  /// Factory used to create and a single instance during the program run
  factory MediaDataAccessObject() {
    return _mediaDataAccessObject ??= MediaDataAccessObject._();
  }

  Future<Set<Media>> showByDestinationId(Destination destination) async {
    if (destination.id == null) {
      throw ArgumentError("destination id cannot be null");
    }

    Uri uri = Uri.parse('$resourceUrl/destination/${destination.id}');

    var response = await get(uri);

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

    Uri uri = Uri.parse('$resourceUrl/source/${source.id}');

    var response = await get(uri);

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

        Media source = Media.fromJson(json['data']);
        cache.add(source);
        return Future.value(source);
      case 404:
        return Future.value(null);
      default:
        throw response;
    }
  }
}
