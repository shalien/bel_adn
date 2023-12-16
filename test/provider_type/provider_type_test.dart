import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  ProviderType? createdProviderType;
  ProviderType? updatedProviderType;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );
  });

  group('ProviderType - CRUD', () {
    test('ProviderType - Index', () async {
      var providerTypes = await client.providerTypes.index();

      expect(providerTypes, isA<List<ProviderType>>());
      expect(providerTypes.length, greaterThan(0));
    });

    test('ProviderType - Store', () async {
      var toStore = ProviderType('test');

      createdProviderType = await client.providerTypes.store(toStore);

      if (createdProviderType == null) {
        throw Exception('ProviderType is null');
      }

      expect(createdProviderType, isA<ProviderType>());
      expect(createdProviderType?.name, toStore.name);
      expect(createdProviderType?.id, isA<int>());
      expect(createdProviderType?.id, greaterThan(0));
    });

    test('ProviderType - Show', () async {
      if (createdProviderType == null) {
        throw Exception('ProviderType is null');
      }

      var providerType =
          await client.providerTypes.show(createdProviderType!.id!);

      expect(providerType, isA<ProviderType>());
      expect(providerType.name, createdProviderType?.name);
      expect(providerType.id, createdProviderType?.id);
    });

    test('ProviderType - Update', () async {
      if (createdProviderType == null) {
        throw Exception('ProviderType is null');
      }

      ProviderType? toUpdate = createdProviderType?.copyWith(name: 'test2');

      if (toUpdate == null) {
        throw Exception('ProviderType is null');
      }

      updatedProviderType =
          await client.providerTypes.update(createdProviderType!.id!, toUpdate);

      if (updatedProviderType == null) {
        throw Exception('ProviderType is null');
      }

      expect(updatedProviderType, isA<ProviderType>());
      expect(updatedProviderType?.name, toUpdate.name);
      expect(updatedProviderType?.id, createdProviderType?.id);
    });

    test('ProviderType - Delete', () async {
      if (createdProviderType == null) {
        throw Exception('ProviderType is null');
      }

      var deletedProviderType =
          await client.providerTypes.delete(createdProviderType!.id!);

      expect(deletedProviderType, isTrue);
    });
  });

  tearDownAll(() {
    if (createdProviderType != null && createdProviderType!.id != null) {
      client.providerTypes.delete(createdProviderType!.id!);
    }
  });
}
