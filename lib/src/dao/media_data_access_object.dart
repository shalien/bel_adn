import 'dart:convert';
import '../data_access_object.dart';
import '../models/media.dart';
import '../response_exception.dart';

/// The singleton instance for the factory
MediaDataAccessObject? _mediaDataAccessObject;

/// The [DataAccessObject] for the [Media] class
class MediaDataAccessObject extends DataAccessObject<Media> {
  /// Private constructor
  MediaDataAccessObject._(String host) : super(host, "medias");

  /// Factory used to create and a single instance during the program run
  factory MediaDataAccessObject(String host) {
    return _mediaDataAccessObject ??= MediaDataAccessObject._(host);
  }

  /// This method will delete a [Media] from the server
  @override
  Future<bool> destroy(Media t) async {
    String uri = '$resourceUrl/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.delete(url, headers: headers);

    return response.statusCode == 200;
  }

  /// Will return all the [Media] from the server
  @override
  Future<List<Media>> index() async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    List<Media> medias = <Media>[];

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> decodedResponse = json.decode(response.body);

      for (dynamic element in decodedResponse) {
        medias.add(Media.fromJson(element));
      }
    } else {
      throw ResponseException(response);
    }

    return medias;
  }

  /// Will return a [Media] based on the [id]
  @override
  Future<Media> show(int id) async {
    String uri = '$resourceUrl/$id';
    Uri url = Uri.parse(uri);

    var response = await client.get(url, headers: headers);

    if (response.statusCode != 200) {
      throw ResponseException(response);
    }
    return Media.fromJson(json.decode(response.body));
  }

  /// Will try to save the [Media][t] to the server
  @override
  Future<int> store(Media t) async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    var response = await client.post(url, body: t.toJson(), headers: headers);

    if (response.statusCode != 200) {
      throw ResponseException(response);
    }
    return json.decode(response.body)['id'];
  }

  /// Will try to update the [Media][t]
  @override
  Future<bool> update(Media t) {
    return Future.value(false);
  }
}
