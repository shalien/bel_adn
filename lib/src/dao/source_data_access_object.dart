import 'dart:convert';

import '../client/bel_adn_client.dart';
import '../client/response_exception.dart';
import '../models/source.dart';
import 'data_access_object.dart';

SourceDataAccessObject? _sourceAccessObject;

class SourceDataAccessObject extends DataAccessObject<Source> {
  SourceDataAccessObject._(String host) : super(host, "sources");

  factory SourceDataAccessObject(String host) {
    if (host.isEmpty) {
      throw ArgumentError("host cannot be empty");
    }
    return _sourceAccessObject ??= SourceDataAccessObject._(host);
  }

  @override
  Future<bool> destroy(Source t) {
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Source t) {
    throw UnimplementedError();
  }

  Future<bool> exists(Uri link) async {
    if (link.toString().isEmpty) {
      throw ArgumentError("link cannot be empty");
    }

    if (cache.find((source) => source.link == link.toString()).isNotEmpty) {
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
        throw ResponseException(response);
    }
  }

  Future<Source?> showByLink(Uri link) async {
    if (link.toString().isEmpty) {
      throw ArgumentError("uri cannot be empty");
    }

    if (cache.find((source) => source.link == link.toString()).isNotEmpty) {
      return Future.value(
          cache.find((source) => source.link == link.toString()).first);
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
        throw ResponseException(response);
    }
  }
}
