import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;
  late ProviderType providerType;

  Supplier? createdSupplier;
  Supplier? updatedSupplier;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    providerType = await client.providerTypes.show(1);
  });

  group('Supplier - CRUD', () {
    test('Supplier - Index', () async {
      var suppliers = await client.suppliers.index();

      expect(suppliers, isA<List<Supplier>>());
      expect(suppliers.length, greaterThan(0));
    });

    test('Supplier - Store', () async {
      var toStore = Supplier('test', providerType.id!);

      createdSupplier = await client.suppliers.store(toStore);

      if (createdSupplier == null) {
        throw Exception('Supplier is null');
      }

      expect(createdSupplier, isA<Supplier>());
      expect(createdSupplier?.host, toStore.host);
      expect(createdSupplier?.id, isA<int>());
      expect(createdSupplier?.id, greaterThan(0));
    });

    test('Supplier - Show', () async {
      if (createdSupplier == null) {
        throw Exception('Supplier is null');
      }

      var supplier = await client.suppliers.show(createdSupplier!.id!);

      expect(supplier, isA<Supplier>());
      expect(supplier.host, createdSupplier?.host);
      expect(supplier.id, createdSupplier?.id);
    });

    test('Supplier - Update', () async {
      if (createdSupplier == null) {
        throw Exception('Supplier is null');
      }

      Supplier? toUpdate = createdSupplier?.copyWith(host: 'test2');

      if (toUpdate == null) {
        throw Exception('Supplier is null');
      }

      updatedSupplier =
          await client.suppliers.update(createdSupplier!.id!, toUpdate);

      expect(updatedSupplier, isA<Supplier>());
      expect(updatedSupplier?.host, toUpdate.host);
      expect(updatedSupplier?.id, createdSupplier?.id);
    });

    test('Supplier - Delete', () async {
      if (createdSupplier == null) {
        throw Exception('Supplier is null');
      }

      var deleted = await client.suppliers.delete(createdSupplier!.id!);

      expect(deleted, isTrue);
    });
  });

  tearDownAll(() async {
    if (updatedSupplier != null) {
      await client.suppliers.delete(updatedSupplier!.id!);
    }

    if (createdSupplier != null) {
      await client.suppliers.delete(createdSupplier!.id!);
    }
  });
}
