import 'dart:convert';

import '../utils.dart';
import 'data_access_object.dart';

import '../models/provider.dart';

class ProviderDataAccessObject extends DataAccessObject<Provider> {
  ProviderDataAccessObject() : super('providers');

  @override
  Future<bool> destroy(Provider t) async {
    String uri = '$baseUri/$prefix/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.delete(url, headers: headers);

    return response.statusCode == 200;
  }

  @override
  Future<List<Provider>> getAll() async {
    String uri = "$baseUri/$prefix";
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

  Future<List<Provider>> getByTopicId(int id) async {
    String uri = '$baseUri/$prefix/topic/$id';
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

  @override
  Future<Provider> getById(int id) async {
    String uri = '$baseUri/$prefix/$id';
    Uri url = Uri.parse(uri);

    var response = await client.get(url, headers: headers);

    if (response.statusCode != 200) {}
    return Provider.fromJson(json.decode(response.body));
  }

  @override
  Future<int> store(Provider t) async {
    String uri = '$baseUri/$prefix';
    Uri url = Uri.parse(uri);

    var response = await client.post(url, body: t.toJson(), headers: headers);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    return json.decode(response.body)['id'];
  }

  @override
  Future<bool> update(Provider t) {
    return Future.value(false);
  }
}
