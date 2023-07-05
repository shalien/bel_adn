import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';
import 'package:meta/meta.dart';

/// The [DataAccessObject] for the [Provider] class
@immutable
class ProviderDataAccessObject extends DataAccessObject<Provider> {
  static ProviderDataAccessObject? _providerDataAccessObject;

  ProviderDataAccessObject._() : super(resource: "providers");

  /// Factory used to create and a single instance during the program run
  factory ProviderDataAccessObject() {
    return _providerDataAccessObject ??= ProviderDataAccessObject._();
  }

  Future<List<ProviderLink>> showWithLinks(Provider provider) async {
    Uri uri = Uri.parse("$resourceUrl/${provider.id}/links");

    var response = await client.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Unable to fetch provider links");
    }

    List<ProviderLink> providerLinks = [];

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
