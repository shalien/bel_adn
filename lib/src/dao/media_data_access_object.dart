import 'dart:convert';

import '../data_access_object.dart';
import '../models/media.dart';

class MediaDataAccessObject extends DataAccessObject<Media> {
  MediaDataAccessObject._(String host) : super(host, "medias");

  @override
  Future<bool> destroy(Media t) async {
    String uri = '$resourceUrl/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.delete(url, headers: headers);

    return response.statusCode == 200;
  }

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
    }

    return medias;
  }

  @override
  Future<Media> show(int id) async {
    String uri = '$resourceUrl/$id';
    Uri url = Uri.parse(uri);

    var response = await client.get(url, headers: headers);

    if (response.statusCode != 200) {}
    return Media.fromJson(json.decode(response.body));
  }

  @override
  Future<int> store(Media t) async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    var response = await client.post(url, body: t.toJson(), headers: headers);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    return json.decode(response.body)['id'];
  }

  @override
  Future<bool> update(Media t) {
    return Future.value(false);
  }
}
