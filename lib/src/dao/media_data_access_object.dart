import 'dart:convert';

import 'package:meta/meta.dart';

import '../client/bel_adn_client.dart';
import '../data_access_object.dart';
import '../model/media.dart';

/// The singleton instance for the factory
MediaDataAccessObject? _mediaDataAccessObject;

/// The [DataAccessObject] for the [Media] class
@immutable
class MediaDataAccessObject extends DataAccessObject<Media> {
  /// Private constructor
  MediaDataAccessObject._(String host) : super(host, "medias");

  /// Factory used to create and a single instance during the program run
  factory MediaDataAccessObject(String host) {
    return _mediaDataAccessObject ??= MediaDataAccessObject._(host);
  }

  /// Will try to update the [Media][t]
  @override
  Future<bool> update(Media t) {
    return Future.value(false);
  }

  Future<bool> exists(Uri link) async {
    if (link.toString().isEmpty) {
      throw ArgumentError("link cannot be empty");
    }

    if (cache.find((media) => media.link == link.toString()).isNotEmpty) {
      return Future.value(true);
    }

    Uri uri = Uri.parse(
        '$resourceUrl/link/${base64Encode(link.toString().codeUnits)}');

    var response = await get(uri);

    switch (response.statusCode) {
      case 200:
        return Future.value(true);
      case 404:
        return Future.value(false);
      default:
        throw Exception(response);
    }
  }
}
