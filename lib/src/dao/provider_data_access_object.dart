import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

/// The [DataAccessObject] for the [Provider] class
@immutable
class ProviderDataAccessObject extends DataAccessObject<Provider> {
  static ProviderDataAccessObject? _providerDataAccessObject;

  ProviderDataAccessObject._(String host, Client client)
      : super(resource: "providers", host: host, client: client);

  /// Factory used to create and a single instance during the program run
  factory ProviderDataAccessObject(String host, Client client) {
    return _providerDataAccessObject ??=
        ProviderDataAccessObject._(host, client);
  }

  Future<Set<Source>> showWithSources(Provider provider) async {
    Uri uri = Uri.parse("$resourceUrl/${provider.id}/sources");

    var response = await client.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    Set<Source> sources = {};

    var decodedResponse = jsonDecode(response.body);

    if (decodedResponse['data'] == null) {
      return sources;
    }

    for (var source in decodedResponse['data']) {
      sources.add(Source.fromJson(source));
    }

    return sources;
  }

  Future<Set<ProviderLink>> showWithLinks(Provider provider) async {
    Uri uri = Uri.parse("$resourceUrl/${provider.id}/links");

    var response = await client.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    Set<ProviderLink> providerLinks = {};

    var decodedResponse = jsonDecode(response.body);

    if (decodedResponse['data'] == null) {
      return providerLinks;
    }

    for (var providerLink in decodedResponse['data']) {
      providerLinks.add(ProviderLink.fromJson(providerLink));
    }

    return providerLinks;
  }
}
