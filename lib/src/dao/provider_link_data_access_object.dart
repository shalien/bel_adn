import 'dart:convert';

import 'package:http/http.dart';

import '../data_access_object.dart';
import '../model/provider.dart';
import '../model/provider_link.dart';

final class ProviderLinkDataAccessObject
    extends DataAccessObject<ProviderLink> {
  static ProviderLinkDataAccessObject? _providerLinkDataAccessObject;

  ProviderLinkDataAccessObject._(String host, Client client)
      : super(resource: 'provider_links', host: host, client: client);

  factory ProviderLinkDataAccessObject(String host, Client client) {
    return _providerLinkDataAccessObject ??=
        ProviderLinkDataAccessObject._(host, client);
  }

  Future<Set<Provider>> showProviders(ProviderLink providerLink) async {
    Uri uri = Uri.parse('$resourceUrl/${providerLink.id}/providers');

    final response = await client.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    var decodedResponse = jsonDecode(response.body);

    var providers = <Provider>{};

    for (var element in decodedResponse['data']) {
      providers.add(Provider.fromJson(element));
    }

    return providers;
  }
}
