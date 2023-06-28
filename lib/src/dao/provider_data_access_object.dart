import 'dart:convert';

import 'package:meta/meta.dart';

import '../data_access_object.dart';
import '../model/provider.dart';
import '../model/topic.dart';

/// The [DataAccessObject] for the [Provider] class
@immutable
class ProviderDataAccessObject extends DataAccessObject<Provider> {
  static ProviderDataAccessObject? _providerDataAccessObject;

  ProviderDataAccessObject._() : super(resource: "providers");

  /// Factory used to create and a single instance during the program run
  factory ProviderDataAccessObject() {
    return _providerDataAccessObject ??= ProviderDataAccessObject._();
  }

  /// Will return all [Provider] linked to the [Topic]'s [id]
  Future<List<Provider>> getByTopicId(int id) async {
    String uri = '$resourceUrl/$id/providers';
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
}
