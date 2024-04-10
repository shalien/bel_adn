import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  ProviderType? createdProviderType;
  ProviderType? updatedProviderType;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('ProviderType - CRUD', () {

    test('ProviderType - Index', () async {
      final providerTypes = await client.providerTypes.index();

      expect(providerTypes, isA<List<ProviderType>>());
      expect(providerTypes, isNotEmpty);
    });

    test('ProviderType - Index - Name', () async {
      final providerTypes = await client.providerTypes.index();

      final ProviderType testProviderType = providerTypes.first;

      final retrievedProviderTypes = await client.providerTypes.index(name: testProviderType.name);

      final retrievedProviderType = retrievedProviderTypes.first;

      expect(retrievedProviderType, isA<ProviderType>());
      expect(retrievedProviderType.name, testProviderType.name);
      expect(retrievedProviderType.id, testProviderType.id);
    });


  });

  tearDownAll(() {});
}
