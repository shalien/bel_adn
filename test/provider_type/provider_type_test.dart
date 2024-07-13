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

  group('ProviderType - CRUD', () {
    test('ProviderType - Index', () async {
      final providerTypes = await client.providerTypes.index();

      expect(providerTypes, isA<List<ProviderType>>());
      expect(providerTypes, isNotEmpty);
    });

    test('ProviderType - Create', () async {
      final providerType = await client.providerTypes.store(
        name: 'test',
      );

      expect(providerType, isA<ProviderType>());
      expect(providerType.name, 'test');
    });
  });

  tearDownAll(() {});
}
