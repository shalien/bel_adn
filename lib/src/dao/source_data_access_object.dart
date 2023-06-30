import 'dart:convert';

import '../client/bel_adn_client.dart';
import '../data_access_object.dart';
import '../model/source.dart';

class SourceDataAccessObject extends DataAccessObject<Source> {
  static SourceDataAccessObject? _sourceAccessObject;

  SourceDataAccessObject._() : super(resource: "sources");

  factory SourceDataAccessObject() {
    return _sourceAccessObject ??= SourceDataAccessObject._();
  }

  Future<bool> exists(Uri link) async {
    if (link.toString().isEmpty) {
      throw ArgumentError("link cannot be empty");
    }

    if (cache.find((source) => source.link == link).isNotEmpty) {
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
        throw Exception(response);
    }
  }
}
