import 'dart:convert';

import 'package:meta/meta.dart';

import '../client/bel_adn_client.dart';
import '../data_access_object.dart';
import '../model/media.dart';

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
