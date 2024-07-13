import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Supplier - CRUD', () {
    test('Create', () async {
      var prodiderType = (await client.providerTypes.index(name: 'test')).first;

      client.suppliers.store(
          host: 'http://localhost:8000', providerTypeId: prodiderType.id);
    });
  });

  tearDownAll(() async {});
}
