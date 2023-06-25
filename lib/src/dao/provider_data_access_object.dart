import 'dart:convert';

import 'package:meta/meta.dart';

import '../../models.dart';
import '../data_access_object.dart';

ProviderDataAccessObject? _providerDataAccessObject;

/// The [DataAccessObject] for the [Provider] class
@immutable
class ProviderDataAccessObject extends DataAccessObject<Provider> {
  ProviderDataAccessObject._(String host) : super(host, "providers");

  /// Factory used to create and a single instance during the program run
  factory ProviderDataAccessObject(String host) {
    return _providerDataAccessObject ??= ProviderDataAccessObject._(host);
  }

  /// Will return all [Provider] linked to the [Topic]'s [id]
  Future<List<Provider>> getByTopicId(int id) async {
    Topic? topic = _topicCache.get(id);

    if (topic != null) {
      //return topic.providers;
    }

    String uri = '$resourceUrl/topic/$id';
    Uri url = Uri.parse(uri);

    List<Provider> providers = <Provider>[];

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<dynamic, dynamic> decodedResponse = json.decode(response.body);

      if (decodedResponse['data'].isEmpty) {
        return providers;
      }

      for (var element in decodedResponse['data']) {
        providers.add(Provider.fromJson(element));
      }
    } else {
      throw Exception(response);
    }

    return providers;
  }

  Future<List<Media>> getMedias(int id) async {
    String uri = '$resourceUrl/$id/medias';
    Uri url = Uri.parse(uri);

    List<Media> medias = <Media>[];

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);

      if (decodedResponse['data'].isEmpty) {
        return medias;
      }

      for (var element in decodedResponse['data']) {
        medias.add(Media.fromJson(element));
      }
    } else {
      throw Exception(response);
    }

    return medias;
  }

  /// Will update the [Provider]
  @override
  Future<bool> update(Provider t) {
    return Future.value(false);
  }
}
