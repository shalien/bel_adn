import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );
  });

  test('Search for a topic', () async {
    var topics = await client.topics.index();
    topics.shuffle();

    var search = await client.topics.searches(topics.first);

    if (search.isEmpty) {
      print('No results found for ${topics.first}');
      exit(0);
    }

    for (var search in search) {
      var path = await client.paths.show(search.pathId!);
      var supplier = await client.suppliers.show(search.supplierId!);

      var providerType =
          await client.providerTypes.show(supplier.providerTypeId);

      print(
          'Path: ${path.content} : Supplier: ${supplier.host} : Provider Type: ${providerType.name}');
    }
  });
}
