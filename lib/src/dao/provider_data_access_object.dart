import 'dart:convert';

import '../data_access_object.dart';
import '../models/provider.dart';

/// Private instance for singleton
ProviderDataAccessObject? _providerDataAccessObject;

/// The [DataAccessObject] for the [Provider] class
class ProviderDataAccessObject extends DataAccessObject<Provider> {
  ProviderDataAccessObject._(String host) : super(host, "providers");

  /// Factory used to create and a single instance during the program run
  factory ProviderDataAccessObject(String host) {
    return _providerDataAccessObject ??= ProviderDataAccessObject._(host);
  }

  /// Will destroy the given [Provider]
  @override
  Future<bool> destroy(Provider t) async {
    String uri = '$resourceUrl/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.delete(url, headers: headers);

    return response.statusCode == 200;
  }

  /// Will return all [Provider] on the server
  @override
  Future<List<Provider>> index() async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    List<Provider> providers = <Provider>[];

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> decodedResponse = json.decode(response.body);

      for (dynamic element in decodedResponse) {
        providers.add(Provider.fromJson(element));
      }
    }

    return providers;
  }

  /// Will return all [Provider] linked to the [Topic]'s [id]
  Future<List<Provider>> getByTopicId(int id) async {
    String uri = '$host/api/topics/$id';
    Uri url = Uri.parse(uri);

    List<Provider> providers = <Provider>[];

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<dynamic, dynamic> decodedResponse = json.decode(response.body);

      decodedResponse.forEach((_, value) {
        providers.add(Provider.fromJson(value));
      });
    }

    return providers;
  }

  /// Return the [Provider] with [id]
  @override
  Future<Provider> show(int id) async {
    String uri = '$resourceUrl/$id';
    Uri url = Uri.parse(uri);

    var response = await client.get(url, headers: headers);

    if (response.statusCode != 200) {}
    return Provider.fromJson(json.decode(response.body));
  }

  /// Will store the [Provider][t]
  @override
  Future<int> store(Provider t) async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    var response = await client.post(url, body: t.toJson(), headers: headers);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    return json.decode(response.body)['id'];
  }

  /// Will update the [Provider]
  @override
  Future<bool> update(Provider t) {
    return Future.value(false);
  }
}
